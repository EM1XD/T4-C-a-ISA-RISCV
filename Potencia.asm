.text
.globl main

main:
    addi a0, x0, 6      # m = 6 (el primer argumento)
    addi a1, x0, 6      # n = 6 (el segundo argumento)
    jal ra, Potencia    # llamamos a Potencia(6, 6)
    addi s3, a0, 0      # s3 = el resultado final de la potencia
    jalr x0, ra, 0

Potencia:
    # Ajustamos la pila (stack) para poder guardar registros importantes
    addi sp, sp, -16
    sw ra, 12(sp)     # guardamos la dirección de retorno (ra)
    sw s0, 8(sp)      # guardamos s0 para poder conservar el valor de m

    addi s0, a0, 0     # s0 = m

    # Si n < 1, nos saltamos al caso base
    addi t0, x0, 1
    blt a1, t0, caso_base

    # Utilizamos un caso recursivo: Potencia(m, n - 1)
    addi a1, a1, -1   # n = n - 1
    jal ra, Potencia  # llamamos recursiva a sí misma
    
    # Multiplicamos m * resultado de la llamada anterior
    mul a0, s0, a0    # a0 = m * Potencia(m, n - 1)
    jal x0, fin_potencia

caso_base:
    addi a0, x0, 1    # si n < 1, retornamos 1

fin_potencia:
    # Restauramos la pila y los registros originales
    lw ra, 12(sp)     # recuperamos la dirección de retorno de ra
    lw s0, 8(sp)      # recuperamos el valor guardado de s0 (m)
    addi sp, sp, 16   # liberamos los 16 bytes que usamos en la pila
    jalr x0, ra, 0    # retornamos a la dirección anterior