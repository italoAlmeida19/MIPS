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

	#chama função troca para valores vet[0] e vet[1]
	la $a0, myArray($t0)
	la $a1, myArray($t1)
	jal troca	
	
 	#carrega parametros pra funçao numeroAleatorio
 	li $a0, 10
 	li $a1, 15
 	li $a2, 20 
 	li $a3, 25
 	li $t0, 30 	
 				#coloca quarto parametro na pilha 
 	addi $sp , $sp , -4 	# Ajusta a pilha
	sw $t0 , 0( $sp ) 	# Salva $t0 na pilha
	
 	jal numeroAleatorio
 	
 	move $s4, $v0  		#guarda em s4 o resultado da função 
 	addi $sp , $sp , 4      # Ajusta a pilha
 	
			