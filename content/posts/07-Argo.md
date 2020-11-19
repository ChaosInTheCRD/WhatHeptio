---
title: "Want to become Argo-Naut? A beginners guide to Kubernetes native CI/CD"
date: 2020-10-30T09:13:36+01:00
draft: false
tags: ["Kubernetes", "CI/CD", "Tools"]
categories: ["Tools and platforms"]
description: "So you want to captain your very own Kubernetes vessel... but don't know where to start? Look no further."
featured_image: "/img/07-Argo/argo-banner.jpg"
featured_image_preview: "/img/07-Argo/argo-banner.jpg"
---
You won't be travelling with Jason in search of the [Golden Fleece](https://en.wikipedia.org/wiki/Argo)... you'll be doing something **much** cooler.
<!--more-->
##### Todays Post Anthem
<div align="centre">        
 <iframe src="https://open.spotify.com/embed/track/3yedAPQR40bvg10auxmJZG" width="300" height="80" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>

 *How about some floating points in our Argo workflows... 👀*

 So if you have been following the perilous, corageous adventure through the cloud-native landscape and the seemingly endless slew of YAML indentations buried within it, you'd know that I have explored a fair few pillars of the tools and components that sit on top of Kubernetes. We have an ingress controller giving users a public endpoint to access, Monitoring and logging systems so that you can lord over your hard work, disaster recovery tooling... the list goes on and on.

 But what if you are left wanting more? Maybe you feel that there is a layer of sophistication to be discovered that you have not yet touched. You are left trembling over the exhilarating prospect of such layers existing. All of a sudden, your mind screams *"CI/CD!"* in a ghoulish howl, filled with malice. But you think to yourself in terror... "I don't even know what that means!". Your mind turns back to the conferences you have attended, where any mention of the word leads to an unsure, yet conforming nod, to save all chances of embarrassment. To which your mind replies, "I know, what the heptio right? how exciting" 😈.

<figure>
<img src="/img/07-Argo/more-yaml1.gif" />
<figcaption>
<h4>When you find out that there is more YAML to configure</h4>
</figcaption>
</figure>

### What even is CI/CD?
So I am sure that you have seen this concept explained or referenced multiple times before, but that doesn't mean that it makes sense to you yet. Without going to far into the details, the acronym stands for Continuous Integration, Continuous Delivery. Still not sure? Well:

#### Continuous Integration
This concept surrounds not the idea of QA testing software as it is prepared for production, but before, with helpful systems that check for syntax errors, code quality/compatibility checking and more. As far as this post is concerned, this is not so much of a focus, but the importance of this within projects cannot be understated.

Want an example? Imagine an example where you are making a game. The code for your game sits on Github. You clone the repo and you get to work. Upon making a change to the source code, you have to work further to ensure that it runs and the core functionality of the game is intact. To make matters even more complicated, your game runs in Kubernetes and relies on the existence of a variety of CRDs and maybe even a database. This means that you have to run it on a local [kind cluster](https://kind.sigs.k8s.io/) where all of these resources can be made available to the app you are testing.

Could it get more of a headache? Yes! Your friend wants in on the action and creates a new branch on the Github repository that you work in. He doesn't know how to test? how do I know if his code will work when I am reviewing the merge request? Problems, problems everywhere! This is where CI is your new best friend.

#### Continuous Delivery / Continuous Deployment
This is where we will be looking today. The idea of CD involves the automation of the process in which changes to the application are 'delivered' to the production environment, with as little interruption to the client side as possible, but preferably none. This has the potential to make your Kubernetes cluster even more kickass! How? Let's look at an example.

Currently I am writing this blog post, amongst other things. Maybe I am also working on some theming, a publically accessible Grafana dashboard, or some other wacky feature. Currently, a push to the main branch of the Github repo triggers a build of the docker image that Kubernetes uses to run the blog in the way you are consuming it right now. But unfortunately, it still requires intervention from myself to delete the pod on the cluster, before Kubernetes pulls the latest image and we get the most up to date version of my memoirs.

Imagine a world where a git push to a "staging" branch triggered a process in which a "staging" version of the site was made available for my own personal QA testing environment, with a public endpoint of `staging.whattheheptio.com` (hint: this might actually be an easter egg 🥚). After glossing over the staging version, I am happy with my code and it is made available on `whattheheptio.com`. Flawless! Wouldn't that be great? Yes, it would. Which is why I am going to do just that. With Argo!

To read more about the wider subject of CI/CD from a theoretical standpoint, I recommend [this](https://medium.com/tilicholabs/what-is-ci-cd-c7c047b80e6b#:~:text=CI%2FCD%20is%20a%20solution,phases%20to%20delivery%20and%20deployment.) article. 

### CD'ing The Blog Site with Argo
First of all, let me introduce you to Argo. I know what you're thinking, yes it is the coolest logo of all the CNCF projects. But don't be fooled by it's cute exterior, this tool is extroardinarily powerful 🥊.

{{<figure src="/img/07-Argo/argo-logo.png">}}

Argo is a container native workflow engine for Kubernetes. What does that mean? Well continuous delivery tools typically provide controllers that can take manifests (yes more YAML) as input that describe the delivery jobs or *pipelines* that can be executed when application changes have been made. In Argo-land, these manifests are called [Workflow Templates](https://argoproj.github.io/argo/workflow-templates/) which, you guessed it, describe [Workflows](https://argoproj.github.io/argo/workflow-concepts/), the computational tasks that apply the changes to your production infrastructure.

But let me prompt you to read that first sentence over again. The magic sauce here are the words **"container-native"** and **"for Kubernetes"**. The latter statement of "for Kubernetes" refers to the fact that it is a controller running in a dedicated Kubernetes namespace, with it's resources all defined in CRDs. This means that using argo, you can easily for instance, the `Workflows` and `WorkflowTemplates` can easily be listed and manipulated using the `kubectl` client you should be getting all so familiar with by now. But where things get really exciting is in the fact that Argo is **container-native**. This means that every 








