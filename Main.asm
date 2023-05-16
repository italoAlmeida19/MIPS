.data
 	newline: .asciiz "\n"
 	newSpace: .asciiz " "
 	soma: .asciiz "soma: "
 	myArray:
 	.align 2 	#alinha palavra na posição correta 
 	.space 80	#array de 20 inteiros
 .text 
 	#AVISO AVISO AVISO
 	#O MAIN NAO ESTÁ PRONTO CORRETAMENTE, ELE ESTÁ FEITO DE FORMA QUE RODE PARA TESTAR AS FUNÇÕES
 	
 	.main:  
 	 	
 	 li $t0, 80 #tamanho de myArray
 	 li $t1, 71 #valor passado para inicializaVetor
 	 la, $s0, myArray
 	 move $t2, $zero #primeira posição do vetor
 	 	
 	 #CHAMA INICIALIZAVETOR
 	 move $a0, $s0 #endereço primeira posição vetor
 	 move $a1, $t0 #move para o paramentro o tam do vetor
 	 move $a2, $t1 #move o valor passado para a função
 	 jal inicializaVetor
 	 move $s1, $v0 #guarda o valor da soma
 	 
 	 #CHAMA IMPRIME VETOR
 	 move $a0, $s0 #endereço primeira posição vetor
 	 move $a1, $t0 #tam
 	 jal imprime
 	 
 	 #CHAMA ORDENA VETOR
 	 move $a0, $s0 #endereço primeira posição vetor
 	 move $a1, $t0 
 	 jal ordenaVetor
 	 
 	 #CHAMA IMPRIME VETOR
 	 move $a0, $s0 #endereço primeira posição vetor
 	 move $a1, $t0 #tam
 	 jal imprime
 	 
 	 #CHAMA ZERAVETOR
 	 move $a0, $s0 #endereço primeira posição vetor
 	 add $a1, $s0, $t0 #vetor na posição final
 	 jal zeraVetor
 	 
 	 #CHAMA IMPRIME VETOR
 	 move $a0, $s0 #endereço primeira posição vetor
 	 move $a1, $t0 #tam
 	 jal imprime
 	 
 	 #IMPRIME A SOMA NO FINAL
 	 la $a0, soma
 	 li $v0, 4
 	 syscall
 	 
 	 move $a0, $v0
 	 li $v0, 1
 	 syscall
