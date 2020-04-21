---
title: "When disaster strikes, count on... Velero?"
date: 2020-04-16T16:16:01+01:00
draft: false
tags: ["Kubernetes", "Tools", "Disaster Recovery"]
categories: ["Tools and Platforms"]
description: "How can Velero save your bacon?"
featured_image: "/img/05-Velero/veleros.jpg"
featured_image_preview: "/img/05-Velero/veleros.jpg"
---
The open source tool that makes backing up your Kubernetes Cluster plain sailing!
<!--more-->
Well surprise surprise, it looks like I'm back! Not at all the length of time that I was planning to be away for, but certain events (that I'm sure you will not want to spend another minute hearing about) led me to put our curious voyage together through the mystical universe of cloud-native, on the back burner for a little while. Now now, of course that does not mean that I haven't been exploring myself; in fact, quite the contrary.

### So what have I been up to?
That's a great question! The past few weeks has actually given me a considerable amount of time to play around with a selection of different projects; some more productive than others; but alas, many of them could very happily be discussed on this blog, without having me veer off topic. Hopefully over the next few weeks, I will take strides to write some chapters on WTH explaining them. To tease your taste buds, here is a sneak preview of what I have been up to:

- Migration of Kubernetes workloads away from GCP, onto a freshly squeezed kubeadm-based home server 🍋
- The curious case of the kettle in the kitchen that corrupted the single-node etcd cluster 🔌⚡️
- Redesigning Kubernetes to be a Highly available, medusa-like god figure 🦹🏻‍♀️
- Securing Dashboards with OAuth2 Proxy magic 🐇


## Enough chit chat, tell me about Velero
Okay, okay I hear you, listening to my invalid excuses isn't much fun for anyone. But funnily enough, neither is system failure. And what's worse than system failure? I'll tell you for free; system failure with no disaster recovery solution! No disaster recovery solution, mitigation, or protection, for the kubernetes empire that you have worked tirelessly to setup over many months, if not years. But this begs the question; if your workloads are running in ephemeral containers, why not treat your cluster as an ephemeral beast as well?

### Ephemeral? What the Heptio?
In the world of cloud native, containers by and large are treated to be ephemeral entities. In essence, this means their lifetime is viewed to be very short, before dying a valiant death. For this reason, data that we want to persist after a said death, to be used by the next container that comes along, is given its own dedicated resource to live. In Kubernetes, this resource is called a persistent volume (PV), and solves many headaches. Try deploying [Grafana](https://whattheheptio.com/2020/03/04-prometheus/) dashboards on Kubernetes without any persistent storage; you'll see what I mean!


### And my Kubernetes Manifests... Where are they stored?
Aha! now you're asking some important questions. The Kubernetes [manifests](https://devspace.cloud/docs/cli/deployment/kubernetes-manifests/what-are-manifests), are a big stack of yaml files that are presented to the API server. They describe the what, when, how and why of every application running on the cluster, and are stored on a database called [etcd](https://etcd.io/). Without going into this too deeply (I shall save it for another instalment), this a distributed, reliable key-value store; that is accessible cluster-wide. Due to its distributed nature, etcd usually runs in a cluster model of multiple nodes; just like kubernetes. Most commonly, this cluster is set up as a selection of docker containers. Containers everywhere!

So what happens when you have a single node etcd cluster has its data corrupted? What happens when the power goes out in your house, and you power your cluster back on to find that your etcd node isn't responding? Well, of course i'm talking from experience, so I can tell you. You cry for a while, and then get up and say; looks like we'll have to just build all over again.

<figure>
<img src="/img/05-Velero/sandcastle.gif" />
<figcaption>
<h4>What happened to my old cluster? 😭</h4>
</figcaption>
</figure>

### Planning for the inevitable
Well guess what, in the world of Kubernetes, disaster recovery is not something you should think about on Day 2, or Day 1... it should be thought out and implemented on day 0. The beauty of treating your containers as ephemeral, is that they can fail relatively frequently, and kubernetes will spin up new ones to take their place; mounting the persistent data in the appropriate places. But as highlighted by the etcd anecdote... my cluster would maybe benefit from taking some inspiration from this 'Live fast, die young' attitude that the containers it runs have adopted. Its about time we designed our cluster with failure in mind; what do you say? Well... you say "What the Heptio? How do I do that?"...


## How about Velero!


