---
title: "Prometheus 4"
date: 2020-03-04T11:00:56Z
draft: false
---

In my last article, I mentioned an open-source platform called Prometheus. Now if you are in anyway involved with the cloud native ecosystem, it's more than likely that you will come across it before. After all, it shares a name with a Greek Titan that played a part in the world famous 'Alien' movies 👽. But then I tell you that it is a monitoring and alerting toolkit that includes data scraping and storing, it's own querying language called 'PromQL' and a built in alert manager. Yes, that sounds great... but... what does that mean? Well here we go again!

## Prometheus... What the Heptio? 🤷‍♂️
Now let's build ourselves a scenario. You're like me, and you've just set up your first all singing, all dancing kubernetes cluster on GKE 🎵. Whether you know it or not (I definitely didn't to begin with), this is a very simple, turnkey experience. What I mean by this is that from go, a lot of the components of the cluster are setup for you, and their presence just fades into the background (within the darkest depths of the Google Cloud Platform 👻).

You think to yourself 'I wonder how my cluster is performing. What pods are using up the most memory, how much traffic am I getting through my contour ingress controller? Well.. that certainly is an interesting question. You have a scroll through the GCP web UI and the built in functions just throw it into your lap and you don't need to make a second thought. But... where is that really coming from? and if you haven't asked this question... and spun up something more vanilla afterwards, like Kubeadm; why aren't these same capabilities just given to to me in the same way? Now we're talking 🕵🏻‍♂️.

Prometheus is a set of tools that you'll want to get for native logging and monitoring experience on many container orchestrators. And what makes it so widely acclaimed? Well, a couple of things. First of all it has a powerfully simple querying language, so it's users can analyse their Kubernetes, Docker Swarm, Apache Mesos, Cloud Foundry... or just Kubernetes 🙃 clusters down to the minute details with ease.

Whats more? Prometheus was the second project to be officially supported by the Cloud Native Computing Foundation, along with Kubernetes and Envoy (mentioned in the first article for this [blog]())

