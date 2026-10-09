.text
.globl main

main:
    # s0 = selector, s1 = a, s2 = b, s3 = c

    addi s0, x0, 1          # selector = 1
    addi s1, x0, 5          # a = 5
    addi s2, x0, 3          # b = 3
    addi s3, x0, 0          # c = 0

    addi t0, x0, 1          # t0 = 1 (en el case 1)
    addi t1, x0, 2          # t1 = 2 (en el case 2)
    addi t2, x0, 3          # t2 = 3 (en el case 3)

    # switch (selector)
    beq s0, t0, case_suma      # si el selector == 1, se salta a la suma
    beq s0, t1, case_resta     # si el selector == 2, se salta a la resta
    beq s0, t2, case_multiplica # si el selector == 3, se salta a la multiplicacion
    jal x0, case_default       # si es que no coincide se va a al default

case_suma:
    add s3, s1, s2        # c = a + b
    jal x0, fin_switch    # terminamos con esta operacion

case_resta:
    sub s3, s1, s2        # c = a - b
    jal x0, fin_switch    # terminamos con esta operacion 

case_multiplica:
    mul s3, s1, s2        # c = a * b
    jal x0, fin_switch    # terminamos con esta operacion 

case_default:
    and s3, s1, s2        # c = a & b
    jal x0, fin_switch    # terminamos con esta operacion 

fin_switch:
    # Fin del programa
    jalr x0, ra, 0
    