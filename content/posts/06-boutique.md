---
title: "Boutique"
date: 2020-05-30T22:13:36+01:00
draft: false
tags: 
categories: 
description:
featured_image:
featured_image_preview:
---

The open source tool that makes backing up your Kubernetes Cluster plain sailing!
<!--more-->
##### Todays Post Anthem
<div align="centre"> 
 <iframe src="https://open.spotify.com/embed/track/6yfnmzXX7TQ3sfjr7jUNtb" width="300" height="80" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>


 Okay! So hear we go :) 

The first ingredient that we require on this exciting journey to our first ever live public shop for the boutique lovers is the world is a suitably 'classy' cluster. this is where you the gcloud SDK binary that you installed earlier will come in handy:

```console
gcloud container clusters create classy-cluster --enable-autoupgrade \
    --enable-autoscaling --min-nodes=3 --max-nodes=10 --num-nodes=5 --zone=us-central1-a
```

### Maybe mention Sonobuoy

now that we have a working cluster, type `kubectl get nodes` to check the status of the nodes in the cluster and that they are all healthy.

Also worth noting that you should make use of kubectx / kubens for multi-tasking purposes... it's a nice trick!

--------------

## deploying our boutique store... 3, 2, 1... we have liftoff
now what we will be using to deploy our bougie website is a github project made by google... Don't worry, we won't be building from scratch; that would maybe be out of the scope of this post.

kubectl apply -f , blah blah blah

## Making our site accessible
Unlike my weakling kubeadm homelab cluster, GKE is backed by the might of its loadbalancing service that can expose kubernetes deployments to the wide world with its own dedicated external IP.

kubectl get svc will bring up the services that have been deployed to our cluster from the resources we threw at it earlier. the frontend-external service is the guy we're looking for... and you want to pay attention to the 'External-IP'. This will hang on pending for a while, while it waits for the Google Load Balancer API to return back with our very own unique 
public IP.

But there's one problem... we're not really going to just give all our pals this IP address on the back of a napkin. doesn't sound very 'boutique if you ask me'. I hear you say, 'oh we can just map the IP with an A record to my domain name on the DNS'. Well, you would be correct, but I have a more effective 'kubernetes way' to do this part. Introducing the beauty of 'ingress'.

## Persistence is a virtue

## 'not secure' is not saville row compatible


