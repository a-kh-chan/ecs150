#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>

#define CMDLINE_MAX 512

// variables for background jobs
pid_t bg_pid = -1; //bg process PID
char bg_cmd[CMDLINE_MAX];
int bg_active = 0;
int last_was_background = 0; // last command was a bg job?

int sys_pipeline(char *commnd) //piping
{
        char *cmds[4]; // array to store up to 4 commands 
        int valid_cmds = 0; // how many valid commands stored in cmds
        char cp[CMDLINE_MAX]; 

        strncpy(cp, commnd, CMDLINE_MAX);// duplicating original commnd
        char *token = strtok(cp, "|"); // tokenizing based on deliminator of |

        int pipefd[3][2]; // 3 pipes max for 4 commands; each pipe has 2 ends (creating 2d array)

        pid_t pids[4]; // array for PIDs - signed integer type which is capable of representing a process ID (GNU manual)
        int statuses[4]; // exit statuses array ; need to display all 

        // is pipe format correct
        if (commnd[0] == '|' || commnd[strlen(commnd) - 1] == '|'){
                fprintf(stderr, "Error: missing command\n");
                return 1;
        } else if (strchr(commnd, '>') != NULL){
                fprintf(stderr, "Error: mislocated output redirection\n");
                return 1;
        } else if (strchr(commnd, '<') != NULL){
                fprintf(stderr, "Error: mislocated input redirection\n");
                return 1;
        }

        while (token != NULL && valid_cmds < 4){ // parsing until run out of pipe segments (token = NULL) or 4 cmds
                while(*token == ' ' || *token == '\t'){ //trimming spaces & tabs from token
                        token+=1;
                }
                if (*token == '\0'){//if token is empty 
                        fprintf(stderr, "Error: missing command\n");
                        return 1;
                }
                cmds[valid_cmds] = token; // store into cmds array dependent on which valid_cmds it is (less than 4)
                valid_cmds+=1;
                token = strtok(NULL, "|"); // 

                // If the next token is NULL but the original command ends with a pipe
                if (token == NULL && commnd[strlen(commnd) - 1] == '|') {
                        fprintf(stderr, "Error: missing command\n");
                        return 1;
                }
        }

        // pipe creation
        for (int i = 0; i < valid_cmds - 1; i++){ // for n commands, needs n-1 pipes 
                if (pipe(pipefd[i]) < 0){
                        exit(1);
                }
        }


        for (int i = 0; i < valid_cmds; i++){ // each process
                // tokenizing individual commands into args
                char *argv[17];
                char *arg = strtok(cmds[i], " "); // white space as deliminator
                int j = 0;

                while (arg != NULL && j < 16){ //while the token is NOT null and args r less than 16
                        argv[j] = arg;
                        j+=1;
                        arg = strtok(NULL, " \t\n");
                }

                argv[j] = NULL;
                pids[i] = fork();

                if (pids[i] == 0){ // child process
                        // connect the input from previous pipe
                        if (i > 0){
                                dup2(pipefd[i - 1][0], STDIN_FILENO);
                        }

                        // connect the output to next pipe
                        if (i < valid_cmds - 1){
                                dup2(pipefd[i][1], STDOUT_FILENO);
                        }

                        // close all fds in child
                        for (int k = 0; k < valid_cmds - 1; k++){
                                close(pipefd[k][0]);
                                close(pipefd[k][1]);
                        }

                        execvp(argv[0], argv);
                        exit(1);
                }
        }

        // parent closes all pipe fds
        for (int i = 0; i < valid_cmds - 1; i++) {
                close(pipefd[i][0]);
                close(pipefd[i][1]);
        }

        // wait for all children
        for (int i = 0; i < valid_cmds; i++) {
                int status;
                waitpid(pids[i], &status, 0);
                statuses[i] = WEXITSTATUS(status);
        }

        // print completion messages
        fprintf(stderr, "+ completed '%s' ", commnd);
        for (int i = 0; i < valid_cmds; i++) {
                fprintf(stderr, "[%d]", statuses[i]);
        }

        fprintf(stderr, "\n");
        return 0;
}

int sys(char *commnd) // handling cd, pwd, >, <, &, everything thats not piping
{
        char cp[CMDLINE_MAX];
        char spaced_cmd[CMDLINE_MAX] = {0};

        last_was_background = 1; // assume last background job is running
        char display_cmd[CMDLINE_MAX];
        strncpy(display_cmd, commnd, CMDLINE_MAX);
        int background = 0;

        char *argv[17];
        char *out_file = NULL;
        char *in_file = NULL;

        // background execution check
        char *ampersand = strrchr(commnd, '&');
        if (ampersand && *(ampersand + 1) == '\0'){
                background = 1;
                *ampersand = '\0'; // remove the '&'
                // check if there's a pipe (invalid with &)
                if (strchr(commnd, '|')){
                        fprintf(stderr, "Error: mislocated background sign\n");
                        return 1;
                }
        }
        last_was_background = background;

        // adding white space around <, > to parse
        int j = 0;
        int commnd_length = strlen(commnd);
        for (int i = 0; i < commnd_length; i++){
                if (commnd[i] == '>'){
                        spaced_cmd[j] = ' ';
                        j+=1;
                        spaced_cmd[j] = '>';
                        j+=1;
                        spaced_cmd[j] = ' ';
                        j+=1;
                } else if (commnd[i] == '<'){
                        spaced_cmd[j] = ' ';
                        j+=1;
                        spaced_cmd[j] = '<';
                        j+=1;
                        spaced_cmd[j] = ' '; 
                        j+=1;
                } else{
                        spaced_cmd[j] = commnd[i];
                        j+=1;
                }
        }
        
        int i = 0;
        strncpy(cp, spaced_cmd, CMDLINE_MAX - 1);
        argv[i] = strtok(cp, " ");

        /* character parsing */
        while (argv[i] != NULL && i < 17){
                if (strcmp(argv[i], ">") == 0){
                        argv[i] = NULL;
                        out_file = strtok(NULL," ");

                        // handling echo > case for output redirection
                        if (out_file == NULL || strlen(out_file) == 0) {
                                fprintf(stderr, "Error: no output file\n");
                                return 1;
                        }
                        break;
                } else if (strcmp(argv[i], "<") == 0){
                        argv[i] = NULL;
                        in_file = strtok(NULL," ");

                        // handling echo < case for input redirection 
                        if (in_file == NULL || strlen(in_file) == 0){
                                fprintf(stderr, "Error: no input file\n");
                                return 1;
                        }
                        break;
                }
                i+=1;
                argv[i] = strtok(NULL, " ");
        }
        if (i >= 17){
                fprintf(stderr, "Error: too many process arguments\n");
                return 1;
        }

        //handling errors like '> file' in cmd line; if the first argument is null  
        if (argv[0] == NULL || strlen(argv[0]) == 0){
                fprintf(stderr, "Error: missing command\n");
                return 1;
        }

        //pwd (print working directory) 
        // GNU C Library: 14.1 Working Directory Referenced 
        if(strcmp(argv[0], "pwd") == 0){ // strcmp returns 1 if 2 args r identical and 0 otherwise 
                char curwordir[CMDLINE_MAX]; // char for current working directory 
                if(getcwd(curwordir, sizeof(curwordir)) != NULL){
                        printf("%s\n", curwordir);
                        fflush(stdout);
                } else{
                        // instructions say cd and pwd never called with incorrect arguments 
                }
                fprintf(stderr, "+ completed '%s' [0]\n", commnd);
                return 0;
        }

        // cd (current directory) 
        // GNU C Library: 14.1 Working Directory Referenced 
        if(strcmp(argv[0], "cd") == 0){
                int status; // cant exit(1) or else itll terminate 
                if(chdir(argv[1]) == -1){
                        fprintf(stderr, "Error: cannot cd into directory\n");
                        status = 1;
                } else{
                        status = 0;
                }
                fprintf(stderr, "+ completed '%s' [%d]\n", commnd, status);
                return 0;
        }
        
        // regular command 

        // try opening files in parent BEFORE fork
        if (out_file != NULL) {
                int fd = open(out_file, O_CREAT | O_WRONLY | O_TRUNC, 0644);
                if (fd < 0) {
                        fprintf(stderr, "Error: cannot open output file\n");
                        return 1;
                }
                close(fd);
        }

        if (in_file != NULL){
                int fd = open(in_file, O_RDONLY);
                if (fd < 0){
                        fprintf(stderr, "Error: cannot open input file\n");
                        return 1;
                }
                close(fd);
        }

        pid_t pid;
        pid = fork();

        if (pid == 0){
                if (out_file != NULL){
                        int fd = open(out_file, O_WRONLY); // safe because parent already verified
                        dup2(fd, STDOUT_FILENO);
                        close(fd);
                } else if (in_file != NULL){
                        int fd = open(in_file, O_RDONLY);  // safe because parent already verified
                        dup2(fd, STDIN_FILENO);
                        close(fd);
                }
                /* child -- after fork*/
                execvp(argv[0], argv);
                fprintf(stderr, "Error: command not found\n");
                exit(1);
        } else if (pid > 0){
                //int status;
                //waitpid(pid, &status, 0);

                /* parent */
                if (background){
                        // dont wait, store PID and command
                        bg_pid = pid;
                        strncpy(bg_cmd, display_cmd, CMDLINE_MAX);
                        bg_active = 1;
                } else{
                        // wait immediately
                        int status;
                        while (waitpid(pid, &status, WNOHANG) == 0){
                                if (bg_active == 1){
                                        int bg_status;
                                        pid_t done = waitpid(bg_pid, &bg_status, WNOHANG);
                                        if (done > 0){
                                                fprintf(stderr, "+ completed '%s' [%d]\n", bg_cmd, WEXITSTATUS(bg_status));
                                                bg_active = 0;
                                                bg_pid = -1;
                                        }
                                }
                        }
                        // process has finished
                        fprintf(stderr, "+ completed '%s' [%d]\n", display_cmd, WEXITSTATUS(status));
                }
        } else{
                exit(1);
        }
    return 0;
}

int main(void){
        char cmd[CMDLINE_MAX];
        char *eof;

        while (1){
                char *nl;

                /* Print prompt */
                printf("sshell@ucd$ ");
                fflush(stdout);

                /* Get command line */
                eof = fgets(cmd, CMDLINE_MAX, stdin);
                if (!eof){
                        /* Make EOF equate to exit */
                        strncpy(cmd, "exit\n", CMDLINE_MAX);
                }

                /* Print command line if stdin is not provided by terminal */
                if (!isatty(STDIN_FILENO)){
                        printf("%s", cmd);
                        fflush(stdout);
                }

                /* Remove trailing newline from command line */
                nl = strchr(cmd, '\n');
                if (nl){
                        *nl = '\0';
                }
                // mislocated & sign
                if (strchr(cmd, '&') && strchr(cmd, '|')){
                        fprintf(stderr, "Error: mislocated background sign\n");
                        continue;
                }
                
                // trying to exit while active job 
                if (!strcmp(cmd, "exit")) {
                        if (bg_active == 1){ //if theres a process still running and youre trying to exit
                                fprintf(stderr, "Error: active job still running\n");
                                fprintf(stderr, "+ completed 'exit' [1]\n");
                                continue;
                        }
                        fprintf(stderr, "Bye...\n+ completed 'exit' [0]\n");
                        break;      
                }
                
                if (strchr(cmd, '|') != NULL){
                        sys_pipeline(cmd);
                } else{
                        sys(cmd);
                }

                // if last command was background, check if done
                if (bg_active == 1){ //aka if its still active
                        int status;
                        pid_t result = waitpid(bg_pid, &status, WNOHANG);
                        if (result > 0) {
                                fprintf(stderr, "+ completed '%s' [%d]\n", bg_cmd, WEXITSTATUS(status));
                                bg_active = 0;
                                bg_pid = -1;
                        }
                }
        }
        return EXIT_SUCCESS;
}
