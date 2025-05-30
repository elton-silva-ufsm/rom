Plano de Estudos para Projeto de ROM com ECC (2 meses de projeto, começa em 1 mês)
📅 Duração do plano: 4 semanas (antes do início do estágio)

🧱 1. Revisão e Prática em HDL (SystemVerilog/VHDL)
Objetivo: Garantir domínio em modelagem de ROM, controle de leitura e integração com blocos ECC.
Conteúdo:
    Implementação de ROMs com inicialização por arquivo ($readmemh, etc.)
    Módulo de detecção/correção com Hamming SECDED (Single Error Correction, Double Error Detection)
    Modelagem de decodificadores combinacionais eficientes
Tarefas:
    ✅ Implementar ROM 32 bits x N palavras com Hamming SECDED
    ✅ Simular casos de erro único e duplo
    ✅ Analisar criticidade do caminho lógico (Critical Path)
Recursos sugeridos:
Clifford Wolf's Yosys Tutorials
IEEE 1164 VHDL or IEEE 1800 SystemVerilog specs


⚙️ 2. Ferramentas de Síntese e P&R (Genus + Innovus)
Objetivo: Otimizar tempo de acesso da ROM com ECC, gerenciar área e timing.
Conteúdo:
    Floorplanning básico para IPs pequenos
    Otimização para latência mínima
    Análise de timing com e sem ECC
    Constraints (.sdc) para clock, I/O, área
Tarefas:
    ✅ Síntese e P&R de uma ROM com e sem ECC
    ✅ Verificar impacto em setup e hold
    ✅ Gerar relatórios de timing e área
Dica: Estude pipelining condicional caso o ECC cause aumento indesejado na latência.


🧮 3. Códigos de Correção de Erros (ECC)
Objetivo: Ter domínio em Hamming (SECDED), sua lógica e limitações.
Conteúdo:
    Hamming (7,4), (72,64), generalização para 32 bits
    Geração e verificação do syndrome vector
    Decodificador lógico para identificar e corrigir o erro
Tarefas:
    ✅ Construir tabela verdade para detecção e correção
    ✅ Implementar um ECC encoder/decoder em Verilog
    ✅ Simular com erro injetado
Recursos sugeridos:
Livro: Error Control Coding – Lin & Costello (capítulos iniciais)
Artigo prático: “ECC Implementation in ASIC Memory” (Synopsys/EDA playground papers)


🧪 4. Testbenches e Verificação
Objetivo: Desenvolver ambiente robusto de verificação funcional e de falhas.
Conteúdo:
    Testbench com injeção de falhas (bit-flip controlado)
    Geração aleatória de endereços e dados com erros
    Verificação funcional com scoreboards e assertions
Tarefas:
    ✅ Criar ambiente de simulação para ECC
    ✅ Validar correção de erro único e detecção de erro duplo
    ✅ Medir cobertura funcional (opcional: uso de UVM leve)


🧠 Extra (Se tiver tempo)
Estudar uso de Hamming hierárquico para blocos maiores
Comparar com BCH simples (dependendo da tecnologia-alvo)
Revisar implicações físicas: DRC, LVS, IR drop para ROMs grandes



📋 Resumo Semanal
Semana
Foco Principal
Entregas/Checkpoints
1
HDL + Código de Hamming
ROM básica com ECC funcionando
2
Síntese e Análise de Timing com Genus
Análise de área e timing
3
P&R com Innovus + Pipeline opcional
Bloco completo com relatórios físicos
4
Testbenches + Verificação ECC
Simulação robusta com injeção de falhas

////// notas

dado:11001010111111101011101011001010
separado: 110010 101111111010111 0101100 101 0

csl: 110010 1 101111111010111 0 0101100 0 101 1 0 10
csl: 01 1 0 100 1 10101111111 1 010111010110001010
hcs: 110010 101111111010111 0101100 1 0 101 100110

010111000101011101111010111010111001010

110010110111111101011100010110001 1 01010 1

6    5    B    F    A    E    5    8    B    5
0110 0101 1011 1111 1010 1110 0101 1000 1011 0101

110010110111111101011100101100010110101

11001011011111110101110010110001011010 big endian, sender, even https://www.compscilib.com/calculate/hamming-code?variation=default

110010 1 101111111010111 0 0101100 0 101 1 0 000 :: 110010 p32 101111111010111 p16 0101100 p8 101 p4 0 p2 p1 p0
110010 1 101111111010111 0 0101100 0 101 1 0 101 :: 110010 p32 101111111010111 p16 0101100 p8 101 p4 0 p2 p1 p0 //resposta tabela

mem[1021] = 77479f96f5
mem[1022] = 7e3c87c5cc
mem[1023] = 1dc19e3b45
mem[1021] = 77479f96f5
mem[1022] = 7e3c87c5cc
mem[1023] = 1dc19e3b45

write_io_file -locations rom.save.io
write_netlist rom_io.v