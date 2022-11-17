# ROS package demo

## Requirements
* docker (checked on Docker version 20.10.21)
* docker-compose (checked on docker-compose version 1.25.0)

## Instruction

1. Run following command: \
```docker-compose up -d```
2. Run following command:  \
```read_logs.sh``` 
    * You should see something like:
        ```
        The CPU usage is: 1.3
        The CPU usage is: 1.5
        The CPU usage is: 0.9
        The CPU usage is: 0.8
        The CPU usage is: 1.1
        ```
3. Open a new terminal in the same folder and run \
```cpu_stress_load.sh```
    * You will see the CPU load was increased:
        ```
        The CPU usage is: 1.3
        The CPU usage is: 1.5
        The CPU usage is: 0.9
        The CPU usage is: 0.8
        The CPU usage is: 1.1
        The CPU usage is: 8.3
        The CPU usage is: 53.8
        The CPU usage is: 53.3
        ```

4. Press "Enter" to stop CPU load
5. Enter "Ctrl+C" in the terminal with "read_logs.sh"
6. Run following command:
```sudo docker-compose stop```
