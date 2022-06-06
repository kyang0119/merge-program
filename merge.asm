
# kuan yang 
# kxy200010@utdallas.edu
# This program merges two ordered lists of integers into a new ordered list.
# The program compare each element of each ordered list and put the smaller one in the merged list, repeate the above step until end 

.data     

              list1: .word 1,4,6,9			# this is list 1 

              list1_size: .word 4			# size of list 1 
	
              list2: .word 0,2,3,7                    # this is list 2 
	 
              list2_size: .word 4                     # size of list 2 

              merged_list: .word 0:8                  # new empty list

             list3_size: .word 8                     # size of merged list 

              space: .asciiz " "			#space 

              newline: .asciiz "\n"			#next line
                
                
# this is second set of example with different data , to run it , just take of the #(already did) , and comment out the data above 

#.data

#	list1 : .word -3, 0, 6 		#list 1 data
#	list1_size: .word 3		#list 1 size
#	list2: .word -2,0,4,5,9		#list 2 data
#	list2_size: .word 5		#list 2 size
#	merged_list: .word 0:8		#merged list
#	list3_size: .word 8 		#size of merged list
#	space: .asciiz " "		#space
#	newline: .asciiz "\n"		#next line



.text

main:

                li $t0,0                             	# counter i=0

                li $t1,0                            	# counter j=0

                lw $t2,list1_size		     	# load size of list 1 to $t2	

                lw $t3,list2_size                   	# load size of list 2 to $t3

                la $s0,list1 			        # load address of list 1 to $s0

                la $s1,list2 				# load address of list 2 to $s1

                la $s2,merged_list 			#load address of merged list to $s2

loop:                                                                                     

                lw $a0,0($s0)                           # load current element of list 1 into $a0

                beq $t0, $t2,loop_A                     # if i==list1_size, go to loop_A

                lw $a1,0($s1)                           # load current element of list 2 into $a1

                beq $t1,$t3,loop_A                      # if j==list2_size, go to loop_A

                ble $a0,$a1, appendA                    # if list1[i] ≤ list2[j] then append head of list1 (list1[i]) to appendA

                sw $a1,0($s2)                           # otherwise, append head of list2(list2[j]) to merged_list

                add $t1,$t1,1                           # j++

                add $s1,$s1,4                           # point to next element in the list1

                j next					# jumpt to next 

appendA:                                               # append head of list1 to merged_list

                sw $a0,0($s2)				#save head of list1 to merged list

                add $t0,$t0,1                          # i++

                add $s0,$s0,4                          # point next element in the list1

next:    

                add $s2,$s2,4                          # point next location in the merged_list

                j loop				 	#jump back to loop

               

loop_A:                                                  

                lw $a0,0($s0)                            # load head of list1 to $a0
                
                beq $t0,$t2,loop_B			# if i == size of list 1 , jump to loop_B

                add $t0,$t0,1				#  if i != size of list 1 , i ++

                sw $a0,0($s2)				# save head of list1 to merged_list			

                add $s0,$s0,4				# points to the next position of list1

                add $s2,$s2,4				# points to the next  position of merged list

                j loop_A

loop_B:                                                 # if list2 has elements thar are to be added , append them to merged_list

                lw $a1,0($s1)				#load head of list 2 to $a1

                beq $t1,$t3,loop_exit                   # if j == size of list 2 , exit 

                add $t1,$t1,1				# j++

                sw $a1,0($s2)				# save head of list 2 to merged list

                add $s1,$s1,4				# points to the next position of list 2

                add $s2,$s2,4				# points to the next position of merged list

loop_exit:          

                li $t0,0                                 # counter k=0 

                lw $t1,list3_size			#load size of merged list to $t1

                la $s2,merged_list			#load address of merged list to $s2

print_loop:                                             # print the merged_list

                lw $a0,0($s2)                           # load merged_list[k] to $a0

                beq $t0,$t1,exit_print                  # if k==list3_size, exit the loop

                li $v0,1                                # system call to print int , print merged_list[k]

                syscall

                la $a0,space                            # print a space

                li $v0,4				# system call to print string , which is to print space

                syscall

                add $s2,$s2,4                           # point to next element in the merged_list

                add $t0,$t0,1                           # k++

                j print_loop				# jump to print_loop to print the next int 

exit_print:

                li $v0, 10                              # Sets $v0 to "10" to select exit syscall

                syscall                                 # Exit
