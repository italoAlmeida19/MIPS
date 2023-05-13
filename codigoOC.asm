.data
 	newline: .asciiz "\n"
 	newSpace: .asciiz " "
 	myArray:
 	.align 2 #alinha palavra na posição correta 
 	.space 80 #array de 20 inteiros
 .text 
 	.main:    #codigo principal
 	
 	la $a0, myArray #Coloca a primeira posição do vetor dentro do parametro a0
 	li $a1, 20	#Coloca o tamanho do vetor dentro do parametro a1
 	
 	#carrega alguns valores
 	li $s0, 15
 	li $t0, 4
  	li $t1, 8
   	li $t2, 12
    	li $t3, 16
    	
    	#poe essses valores dentro do vetor 
    	sw $s0, myArray($zero)
 	sw $t0, myArray($t0)
 	sw $t1, myArray($t1)
 	sw $t2, myArray($t2)
 	sw $t3, myArray($t3)

 	#chama função imprime 
 	jal imprime
 	
 	#Finaliza programa 
 	li $v0, 10 
 	syscall 
 	
 	
 	imprime:  #função de imprime vetor
 		move $s0, $a0  #Coloca o endereço do vetor que veio por parâmetro dentro de $s0
 		li  $s1, 0     # i = 0 dentro de $s1
 		sll $s2, $a1, 2  #Coloca o tamanho do vetor em bytes dentro de $t2
 			while:
				li $v0, 1          	#Imprimir inteiro
				lw $a0, 0($s0)          #Coloca o valor de vet[i] dentro de a0 p imprimir 
				syscall          	#imprime 
				
				li $v0, 4       	# Espaço entre elementos
				la $a0, newSpace        
				syscall
				
				addi $s0, $s0, 4      #anda 1 posição no vetor
				addi $s1, $s1, 4      #anda a variavel de controle 
				
				blt $s1, $s2, while   #se i > tamBytesVetor quebra o loop
				jr $ra   	    #Volta pra quem chamou
	