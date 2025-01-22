## Assignment Submission  

### Repository Structure 
  **module_1**
    -**command.sh** – Contains commands for all five questions, with each question labeled by its number.  
    -**entire_output.txt** – Stores the output of the entire `command.sh` file execution.  
    -**Q5_output.txt** – Contains only the output of Question 5, as required.  

### How to Run  
  #### Module 1
    To execute the script, run the following command in a terminal:  
    ```bash
    sh command.sh > entire_output.txt
    ```
    This will store all output in `entire_output.txt`.  
     or

     ```bash
    sh command.sh
    ```
    This will print all output in terminal. It doesnot create `entire_output.txt`.  
    
    At the end you will be asked weather to erase all footprint or not. 
      **y** -> Yes, which means you asked the script to delete all empty folder and files created after execution.
      **n** -> No, Which means you don't want to make any change after the execution of command.sh file
      
