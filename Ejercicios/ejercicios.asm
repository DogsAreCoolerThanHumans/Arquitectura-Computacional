.data
ndata: .word 9
vector: .word 1 2 3 4 5 6 7 8 9
result:
.text

add $t0, $zero, $zero ;se guarda en at, se suma zero con zero
la $t0, vector ;load address resume cargar alta y baja, carga vector a t0

lw $a0, ndata ;desde 9
lw $a0, 0($a0) ;contador 0

;ciclo inicia aquí

lw $v1, 0($v0) ;trae datos de memoria a registros, guarda en v1 lo que hay en vector en index 0 (1 de 9)
add $t0, $v1, $t0 ; cargar en at lo que hay en v1 mas at 

addi $v1, $v1, 4; sumar 4 a v1 para desplazar el vector (dirección) de 4 en 4

addi $a0, $a0, -1 ; en a0, suma -1 a a0 (resta)
bne $a0, $zero, ciclo ;compara si a0 not equal a zero, y salta a ciclo

la $t1, result ;cargar en t1 a result (apuntar con t1 a result)
sw $t0, 0($t1) ;carga dato de un registro a memoria


--------------------------
;suma
.data
var_x: .word 5
var_y: .word 6
var_z: 
.text

la $t0, var_x ; carga en t0 dir de varx (t0 apunta a varx)
la $t1, var_y
lw $a0, 0($t0) ; carga en a0 valor de t0
lw $a1, 0($t1)
jal add_function ; salta a etiqueta, pero tmb almacena dir en ra
la $t2, ???
sw $v0, 0($t2)

j exit

add_function:
add $v0, $a0, $a1 ;en v0 suma x y y
jr $ra

exit:

--------------------
;multip

mult_function
add $s7, $zero, $ra ;respaldo de ra para que poder sobreescribir el reg del jal mult
add $t1, $zero, $a1 ;respaldo de y
add $s0, $zero, $zero
ciclo

add $al, $zero, $s0
jal add_function
add $s0, $zero, $v0

addi $t1, $t1, -1
bne $t1, $zero, ciclo
add $v0, $s0, $zero
add $ra, $zero, $s7 ;recuperamos valor respaldado de ra
jr $ra


-----------
;factorial
.data

.text
main:
add $a1, $zero, 4
jal  factorial_function
j exit


factorial_function: 
addi $sp, sp, -12; movemos hacia arriba 3 direcciones de 32 bytes (12 bits) al stack pointer
sw $ra, 0($sp) ;guardamos ra en dir 0 de stack
sw $a1, 4($sp)
sw $a2, 8($sp)

beq $a1, $zero, caso_base ;si a1 es zero, salta caso caso_base
add $a2, $zero, $a1 ;respaldamos a1 en a2
addi $a1, $a1, -1; retamos -1 a n, guardamos en -1
jal factorial_function ;llamamos func, vamos a caso base
mul $v0, $v0, $a2 ;?? 

j exit_factorial
caso_base: ;en caso base, iguala return a 1
addi $v0, $zero, 1

exit_factorial:
lw $ra, 0($sp) ;guardamos ra en dir 0 de stack
lw $a1, 4($sp)
lw $a2, 8($sp)
addi $sp, $sp, 12
jr $ra

exit:

-----
;axb = ax(b-1)mas a 
;$a1 a, $a2 b, return $v0

mult_function:

addi $a3, $a3, 1 

bne $a2, $a3, caso_base ;b=/=1

addi $a2, $a2, -1 ; b-1

jal mult_function  ;agregar mas a 

mult axb
b=/=1
return mult (a,b) mas a
b=1
return a

----------------

prueba git

