# Documentation Installation et Configuration d'un Serveur PXE 

Ce document explique étape par étape comment installer et configurer un serveur PXE (Preboot Execution Environment) en combinant Windows Server et des solutions open source. Ce serveur PXE permettra de déployer des machines en utilisant des images système (Windows/Debian), de faciliter l'automatisation des installations via des scripts, et de sécuriser l'environnement.

---

## Sommaire

1. [Installer et configurer Windows Server](#1-installer-et-configurer-windows-server)  
2. [Installer et configurer le service DNS et ADK](#2-installer-et-configurer-le-service-dns-et-adk)  
3. [Installer et configurer le serveur TFTP (WDS)](#3-installer-et-configurer-le-serveur-tftp-wds)  
4. [Création des Images Windows PE et Debian avec imagex.exe et envoi sur le serveur](#4-création-des-images-windows-pe-et-debian-avec-imagexexe-et-envoi-sur-le-serveur)  
5. [Boot Machine Virtuelle depuis le serveur PXE](#5-boot-machine-virtuelle-depuis-le-serveur-pxe)  
6. [Automatisation de l’installation grâce à AD et à un script PowerShell](#6-automatisation-de-linstallation-grâce-à-ad-et-à-un-script-powershell)  
7. [Sécurisation des Images et du serveur](#7-sécurisation-des-images-et-du-serveur)  
8. [Création d’un Serveur PXE open source](#8-création-dun-serveur-pxe-open-source)  

---

## 1. Installer et configurer Windows Server

**Description :**  
Cette étape consiste à installer Windows Server sur une machine dédiée. Windows Server est la base qui servira à héberger les services nécessaires comme DNS, TFTP, WDS, etc. Vous devez configurer les paramètres réseau du serveur correctement afin qu’il soit accessible à partir d’autres machines.

**Actions :**  
- Préparer les prérequis matériels (disque, mémoire, configuration réseau).  
- Installer Windows Server, et configurer ses rôles de base comme le rôle "Serveur DNS" et "DHCP".  

---

## 2. Installer et configurer le service DNS et ADK

**Description :**  
Le service DNS est essentiel pour garantir la résolution des noms des machines sur le réseau. ADK (Windows Assessment and Deployment Kit) est utilisé pour créer des images personnalisées des systèmes d’exploitation. 

**Actions :**  
- Installer et configurer le service DNS sur Windows Server.  
- Installer ADK depuis le site Microsoft, et inclure les outils liés à Windows PE (environnement préinstallé).  

---

## 3. Installer et configurer le serveur TFTP (WDS)

**Description :**  
Windows Deployment Services (WDS) permet de déployer des OS sur un réseau via PXE. WDS inclut un serveur TFTP qui facilite l'accès aux fichiers nécessaires au boot. TFTP est un protocole léger utilisé pour envoyer les fichiers d’amorçage.

**Actions :**  
- Ajouter le rôle WDS à Windows Server.  
- Configurer WDS pour activer la prise en charge PXE et la communication via TFTP.  
- Indiquer l’emplacement des fichiers boot (images PE ou ISO).  

---

## 4. Création des Images Windows PE et Debian avec imagex.exe et envoi sur le serveur

**Description :**  
Windows PE est une version légère de Windows utilisée pour installer ou réparer des systèmes. Debian est un OS open source qui peut également être déployé via PXE. L’outil **imagex.exe** vous aide à capturer une image système personnalisée.

**Actions :**  
- Utiliser ADK pour créer une image Windows PE personnalisée.  
- Configurer et capturer une image Debian pour être utilisée sur le serveur PXE.  
- Stocker ces images sur le serveur WDS pour qu'elles soient accessibles.  

---

## 5. Boot Machine Virtuelle depuis le serveur PXE

**Description :**  
Cette étape consiste à tester le serveur PXE en démarrant une machine virtuelle ou physique pour récupérer les fichiers d’amorçage et lancer l’installation de l'OS.

**Actions :**  
- Configurer une machine virtuelle dans Hyper-V ou VirtualBox pour utiliser PXE lors du boot.  
- Tester le processus de démarrage depuis le réseau (placé en priorité dans l’ordre de boot).  
- Lancer l’installation de l'OS pour vérifier que tout fonctionne.  

---

## 6. Automatisation de l’installation grâce à AD et à un script PowerShell

**Description :**  
Active Directory (AD) peut être utilisé pour centraliser les comptes et autorisations. En utilisant un script PowerShell, vous pouvez automatiser les installations en attribuant des configurations personnalisées pour chaque machine.

**Actions :**  
- Créer une structure AD avec des OU (Organizational Units) adaptées.  
- Écrire un script PowerShell pour automatiser la sélection des images, configurer des paramètres réseau, et installer des rôles spécifiques sur les machines.  

---

## 7. Sécurisation des Images et du serveur

**Description :**  
Sécuriser le serveur PXE et ses images est primordial pour éviter les accès non autorisés et garantir l’intégrité des fichiers.

**Actions :**  
- Restreindre les accès au serveur via les permissions NTFS.  
- Activer HTTPS pour le transfert des fichiers sensibles entre client et serveur.  
- Scanner les fichiers ISO ou images pour détecter des vulnérabilités éventuelles.  
- Mettre en place des sauvegardes régulières du serveur et des images.  

---

## 8. Création d’un Serveur PXE open source

**Description :**  
Pour une solution entièrement open source, vous pouvez remplacer Windows Server et ses outils par des alternatives telles que **dnsmasq**, **TFTPD**, et **Clonezilla** pour construire un serveur PXE fonctionnel.

**Actions :**  
- Installer une distribution Linux légère (ex : Debian ou Ubuntu).  
- Configurer dnsmasq pour gérer le rôle DNS/DHCP et TFTP.  
- Ajouter support pour des images personnalisées (comme Clonezilla pour le déploiement de sauvegardes).  
- Tester le serveur pour le déploiement d’images et ajuster les paramètres.  

---

Ce guide fournit des étapes détaillées pour construire un serveur PXE. Pour réussir chaque étape, assurez-vous de disposer des prérequis matériels et logiciels nécessaires et de suivre les bonnes pratiques de sécurisation du réseau. Pour tout problème ou information complémentaire, consultez la documentation officielle de Microsoft, Debian ou des outils open source exploités.
