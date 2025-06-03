# DIR_ATUAL=$(pwd)
# export PROJECT_DIR=$(dirname "$DIR_ATUAL")
export PROJECT_DIR=$(pwd)
export DESIGNS="rom"
export TECH_DIR=/home/tools/design_kits/cadence/GPDK045
export HDL_NAME=${DESIGNS}
export VLOG_LIST="$PROJECT_DIR/deliverables/${DESIGNS}.v"
export CLK_PERIOD=100
export BACKEND_DIR=${PROJECT_DIR}/backend
export FRONTEND_DIR=${PROJECT_DIR}/frontend
export SOURCE_DIR=${FRONTEND_DIR}/source
export HDL_FILES="rom.sv hdec.sv"

module load cdn/xcelium/xcelium2409 
module load cdn/genus/genus211 
module load cdn/innovus/innovus211 

echo "Escolha a Ferramenta"
echo "[x] Xcelium"
echo "[g] Genus"
echo "[i] Innovus"

read -r choice

case "$choice" in
x)
    cd ${PROJECT_DIR}/frontend/work || exit
    xrun -clean
    echo "Interface gráfica (s/n)?"
    read -r gui

        if [[ "$gui" == "s" ]]; then
            export GUI="-gui"
        else
            export GUI=""
        fi

    echo "Escolha a Simulação"
    echo "[r] ROM"
    echo "[c] Codificador"
    echo "[d] Decodificador"
    echo "[m] Matriz de dados"

    read -r sim
    case "$sim" in
    c)
        xrun -64bit -timescale 1ns/10ps \
            ${FRONTEND_DIR}/encoder/encoder.sv \
            -access +rwc $GUI
        ;;

    d)
        xrun -64bit -timescale 1ns/10ps \
            ${FRONTEND_DIR}/testbench/hdec_tb.sv \
            ${FRONTEND_DIR}/source/hdec.sv \
            -top tb -access +rwc $GUI
        ;;
    r)
        xrun -64bit -timescale 1ns/10ps \
            ${FRONTEND_DIR}/source/matrix.sv \
            ${FRONTEND_DIR}/source/hdec.sv \
            ${FRONTEND_DIR}/source/rom.sv \
            ${FRONTEND_DIR}/testbench/rom_tb.sv \
            -access +rwc $GUI -top rom_tb \
            -define dir_home="\"../encoder/rom.hex\""
        ;;
    m)
        xrun -64bit -timescale 1ns/10ps \
            ${FRONTEND_DIR}/source/matrix.sv \
            -access +rwc $GUI -top matrix_tb
        ;;
    esac
;;

g)
    cd ${BACKEND_DIR}/synthesis/work || exit
    genus -abort_on_error -lic_startup Genus_Synthesis -lic_startup_options Genus_Physical_Opt -log genus -overwrite \
                      -files ${BACKEND_DIR}/synthesis/scripts/$DESIGNS.tcl
;;


i)
    cd ${BACKEND_DIR}/layout/work || exit
    echo "[d] Abrir Database"
    echo "[i] Abrir Innovus"
    echo "[ENTER] Sintetizar Layout"

    read -r db

    if [[ "$db" == "d" ]]; then
        innovus -stylus -overwrite -db to_drc_lvs.enc -log database.log
    elif [[ "$db" == "i" ]]; then
        innovus -stylus -overwrite -log manual.log
    else
        innovus -stylus -overwrite -files ../scripts/layout.tcl -log synthesis.log
    fi


;;

esac