CSEN 241 - Assignment 3
Student Name: Shuaiyu Wang

Task 1: Defining custom topologies
Questions:
1. What is the output of “nodes” and “net”


mininet> nodes
available nodes are: 
c0 h1 h2 h3 h4 h5 h6 h7 h8 s1 s2 s3 s4 s5 s6 s7
mininet> net
h1 h1-eth0:s3-eth2
h2 h2-eth0:s3-eth3
h3 h3-eth0:s4-eth2
h4 h4-eth0:s4-eth3
h5 h5-eth0:s6-eth2
h6 h6-eth0:s6-eth3
h7 h7-eth0:s7-eth2
h8 h8-eth0:s7-eth3
s1 lo:  s1-eth1:s2-eth1 s1-eth2:s5-eth1
s2 lo:  s2-eth1:s1-eth1 s2-eth2:s3-eth1 s2-eth3:s4-eth1
s3 lo:  s3-eth1:s2-eth2 s3-eth2:h1-eth0 s3-eth3:h2-eth0
s4 lo:  s4-eth1:s2-eth3 s4-eth2:h3-eth0 s4-eth3:h4-eth0
s5 lo:  s5-eth1:s1-eth2 s5-eth2:s6-eth1 s5-eth3:s7-eth1
s6 lo:  s6-eth1:s5-eth2 s6-eth2:h5-eth0 s6-eth3:h6-eth0
s7 lo:  s7-eth1:s5-eth3 s7-eth2:h7-eth0 s7-eth3:h8-eth0
c0
2. What is the output of “h7 ifconfig”
mininet> h7 ifconfig
h7-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.7  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::b4f9:d7ff:fed1:4b04  prefixlen 64  scopeid 0x20<link>
        ether b6:f9:d7:d1:4b:04  txqueuelen 1000  (Ethernet)
        RX packets 60  bytes 4672 (4.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10  bytes 796 (796.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


Task 2: Analyze the “of_tutorial’ controller
Questions:
1. Draw the function call graph of this controller. For example, once a packet comes to the controller, which function is the first to be called, which one is the second, and so forth?
        launch() -> start_switch() -> Tutorial.__init__() -> __handle_PacketIn() -> act_like_hub() -> resend_packet() -> self.connection.send(msg)
2. Have h1 ping h2, and h1 ping h8 for 100 times (e.g., h1 ping -c100 p2).
        a. How long does it take (on average) to ping for each case?
        b. What is the minimum and maximum ping you have observed?
        For a and b, here are the data from the commands:
        "h1 ping -c100 h2":
--- 10.0.0.2 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 101312ms
rtt min/avg/max/mdev = 1.493/3.495/17.763/2.961 ms
        "h1 ping -c100 h8"
--- 10.0.0.8 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 101298ms
rtt min/avg/max/mdev = 7.736/15.485/64.364/10.833 ms
Average time taken for ping in each case
>h1 to h2: 3.475ms
>h1 to h8: 15.265ms
Minimum time taken for ping in each case
>h1 to h2: 1.478ms
>h1 to h8: 7.723ms
Maximum time taken for ping in each case
>h1 to h2:17.742ms
>h1 to h8: 64.799ms
        c. What is the difference, and why?
        The difference I found that is the second scenario will cost more time than the first one. And I think that is because that the h1 wants to ping h2, the number of switches it goes through will be less than the h1 pings h8. So the first scenario didn't need to cost more time for sending packet.


3. Run “iperf h1 h2” and “iperf h1 h8”
        a. What is “iperf” used for?
         It allows users to test the maximum achievable bandwidth between two networked devices by generating TCP and UDP data streams


        b. What is the throughput for each case?
        mininet> iperf h1 h2
*** Iperf: testing TCP bandwidth between h1 and h2 
.*** Results: ['5.00 Gbits/sec', '5.98 Gbits/sec']
mininet> iperf h1 h8
*** Iperf: testing TCP bandwidth between h1 and h8 
*** Results: ['2.00 Gbits/sec', '2.31 Gbits/sec']


        c. What is the difference, and explain the reasons for the difference. 
        The difference I found in this question that is the performance of h1 to h2 will be better than the h1 to h8. I believe the reason will be similar with the second question. Between h1 and h2, there are less switches to travel through, so it takes less time and transfer more data.


4. Which of the switches observe traffic? Please describe your way for observing such traffic on switches (e.g., adding some functions in the “of_tutorial” controller)
        From the source code of of_tutorial, I noticed that the packet actually will be sent to all ports, so I think that all switches will abserve traffic. For observing traffic, I will add some log or print statements in those functions that participate in the process.


Task 3: MAC Learning Controller
Questions:
1. Describe how the above code works, such as how the "MAC to Port" map is established. You could use a ‘ping’ example to describe the establishment process (e.g., h1 ping h2).
        When we do the "h1 ping h2", the _handle_PacketIn() will called the act_like_switch(). So there are two scenarios that is if the source MAC already been known by the "MAC to Port" map and if the destination MAC already been stored by the "MAC to Port" map. For the first scenario, it's the step for estabalishing the map, if the source MAC is unkown, it will add the MAC and its port into the map(key is MAC, value is the port). And for second scenario, it's related to how we send the packet. If the destination is known, it just sends the packet to the destination, or if it's unknown, it will do the same thing as the ac_like_hub()


2. (Comment out all prints before doing this experiment) Have h1 ping h2, and h1 ping h8 for 100 times (e.g., h1 ping -c100 p2).
        a. How long did it take (on average) to ping for each case?
        b. What is the minimum and maximum ping you have observed?
"h1 ping -c100 h2":
--- 10.0.0.2 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 101345ms
rtt min/avg/max/mdev = 1.384/2.300/5.884/0.756 ms
"h1 ping -c100 h8"
--- 10.0.0.8 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 101345ms
rtt min/avg/max/mdev = 7.612/12.183/77.223/8.401ms
Average time taken for ping in each case
>h1 to h2: 2.311ms
>h1 to h8: 12.171ms
Minimum time taken for ping in each case
> h1 to h2: 1.379ms
> h1 to h8: 7.624ms
Maximum time taken for ping in each case
>h1 to h2: 5.975ms
>h1 to h8: 76.998ms

        c. Any difference from Task 2 and why do you think there is a change if there is?
        As we can see the data show us, both Task3's results are improved slightly than Task 2. I think the reason is that the "MAC to Port" map could help us to reduce a lot of time especailly when there are a lot of switches in the process, like the h1 ping h8. After multiple times, the map could have both source and destination MACs, so it can send the pakcet to the destination directly.


3. Q.3 Run “iperf h1 h2” and “iperf h1 h8”.
        a. What is the throughput for each case?
mininet> iperf h1 h2
*** Iperf: testing TCP bandwidth between h1 and h2 
*** Results: ['6.58 Gbits/sec', '7.79 Gbits/sec']
mininet> iperf h1 h8
*** Iperf: testing TCP bandwidth between h1 and h8 
*** Results: ['2.66 Gbits/sec', '3.12 Gbits/sec']
        b. What is the difference from Task 2 and why do you think there is a change if there is?
        The difference between Task 2 and 3 is not really big, but Task 3 also has a small improvement. I think the reason is the same as question 2, the usage of "MAC to Port" map can improve the performance and aid the efficiency.