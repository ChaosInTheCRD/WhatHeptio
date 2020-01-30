---
title: "Lets direct our Kubernetes traffic with... Contour? 🚦"
date: 2020-01-27T10:43:56Z
draft: false

---
So you understand the premise of a container, pretty cool right? You have one way or another been taken through a rundown of how Kubernetes can help harness these nifty little containers, and enable enterprises to run their services with a whole new level of control and efficiency. Now you feel accomplished in your understanding of this new trend, and someone has burst your bubble by uttering a sentence like, "I use contour as my ingress controller as it deploys Envoy as the reverse proxy and load balancer, what do you use?". You sit in your seat paralysed for a brief moment as your short-lived confidence evaporates... and then you bellow... 'What the Heptio?!'.

Well good news, I am going to try and restore your faith in the world of modern applications, and provide an overview of the principles that surround the Contour platform. 👏

&nbsp;

### Brief Side-note

If you don't understand what I mean from the above statement, I guess this is the moment that you navigate to your search bar and get yourself anywhere other than here. Please don't! You are only a couple of lines away from some interesting articles that will free you of those 'What the Heptio' signals your brain is resonating through your soul. Take a look at the provided links to get your head around the container, and how it brought about container orchestrators such as Kubernetes... it's cool, I promise:

[What is Docker? "In Simple English"](https://blog.usejournal.com/what-is-docker-in-simple-english-a24e8136b90b)

[What is Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

_(I also thought the below video would be cool to add, as I think it's actually a pretty neat explanation 😂)_
{{< youtube 4ht22ReBjno >}}
&nbsp;
## **First of all... What the Heptio?**
So you have your Kubernetes cluster. Put simply a collection of compute nodes (machines) that are held to the mercy of a cluster master, that will carry out the instructions it is given. Using the nodes as its workers, it decides which containerised workloads are going to be ran on each of the nodes it has in it's control. Bliss. All you needed to do was define to the master what it was you want, and it takes care of it for you. You run a ```kubectl get pods``` and sit back in your chair with a smug look on your face, as you gaze at your newly created pods, housing a shiny new web application you're going to deploy. And then you think "but how does Kubernetes know how to direct traffic intended for web application to these pods?". Well... it doesn't, at least not yet. This is where Ingress comes in.

In the Kubernetes world, Ingress is a policy defined method of directing external users to services running on a Kubernetes cluster. As forementioned, if you have a bunch of web services running inside pods, you need to make them available from an public IP address or domain (e.g. whattheheptio.com). Kubernetes Ingress features two main components; an ingress controller and ingress resources.

As seen in the diagram below, an ingress controller is a reverse proxy / load balancing service ([handy definition if needed](https://www.nginx.com/resources/glossary/reverse-proxy-vs-load-balancer/)) which once configured routes incoming traffic to the correct application within your cluster. This ingress controller can be chosen by the cluster admin, and there are a few to choose from (e.g. Nginx, Traefik, Contour 😲). The configuration of said controllers is handled by the cluster master, directed by the cluster resources; a collection of rules and configurations provided by yours truly (e.g. YAML file).

![My best shot at a explanatory diagram](/img/post-1/ingress.png)
