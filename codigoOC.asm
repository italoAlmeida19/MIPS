.data
 	newline: .asciiz "\n"
 	newSpace: .asciiz " "
 	myArray:
 	.align 2 #alinha palavra na posição correta 
 	.space 80 #array de 20 inteiros
 .text 
 	.main:    #codigo principal
 	 	
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

 	#chama função imprime para vetor com alguns valores 
 	la $a0, myArray #Coloca a primeira posição do vetor dentro do parametro a0
 	li $a1, 20	#Coloca o tamanho do vetor dentro do parametro a1
 	jal imprime
 	
	#chama função p zerar vetor
 	li $t0, 80               #local da ultima posição do vetor
 	la $a1, myArray($t0)     #endereço para a ultima posição 
 	la $a0, myArray		 #Coloca a primeira posição do vetor dentro do parametro a0
 	jal zeraVetor
 	
 	#chama função imprime para vetor zerado
 	la $a0, myArray 	#Coloca a primeira posição do vetor dentro do parametro a0
 	li $a1, 20		#Coloca o tamanho do vetor dentro do parametro a1
 	jal imprime
 	
 	#Finaliza programa 
 	li $v0, 10 
 	syscall 
 	
 	
 	imprime:  #função de imprime vetor
 		move $t0, $a0  #Coloca o endereço do vetor que veio por parâmetro dentro de $t0
 		li  $t1, 0     # i = 0 dentro de $t1
 		sll $t2, $a1, 2  #Coloca o tamanho do vetor em bytes dentro de $t2
 			while:
				li $v0, 1          	#Imprimir inteiro
				lw $a0, 0($t0)          #Coloca o valor de vet[i] dentro de a0 p imprimir 
				syscall          	#imprime 
				
				li $v0, 4       	# Espaço entre elementos
				la $a0, newSpace        
				syscall
				
				addi $t0, $t0, 4      #anda 1 posição no vetor
				addi $t1, $t1, 4      #anda a variavel de controle 
				
				blt $t1, $t2, while   #se i > tamBytesVetor quebra o loop
				
				li $v0, 4             # Qubra de linha
				la $a0, newline        
				syscall
				
				jr $ra   	      #Volta pra quem chamou
	
	zeraVetor:  #função de zerar vetor
		move $t0, $a0  #guada primeira posição endereço
		move $t1, $a1  #guarda ultima posição endereço
		whileZera:
			bgt $t0, $t1, fim  #posicao inicial > posição final ? caso afirmativo pular para fim 
			sw $zero, 0($t0)   #coloca 0 na vet[atual]
			addi $t0, $t0, 4   #avança para proximo elemento do vetor 
			j whileZera	   #pula para whileZera
		fim:
		jr $ra		           #Volta pra quem chamou
	
	
