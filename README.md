
Liens
==========
Slides https://slides.com/gotorahoutan/epsi-symfony
Repository https://github.com/gototog/codeblog_19-20/
Doc Symfony https://symfony.com/doc/current/index.html
Doc Twig https://twig.symfony.com/doc/2.x/#reference
Doc doctrine https://www.doctrine-project.org/projects/doctrine-orm/en/2.6/reference/query-builder.html
Installation
==========

**A. Phpstorm - IDE**

Installer [PhpStorm](https://www.jetbrains.com/phpstorm/download/)  
1. Choississez votre theme via   `Settings` > `Appearance & Behaviot` > `Appearance` Theme Darcula (noir) ou IntelliJ (blanc)
1. Installer le plugin Symfony
Aller dans `Settings` > `plugins` > `Browse Repository` > installer le `Symfony Plugin`
Pensez à l'activer pour le projet  `Settings` > `Languages and frammwork` > `PHP` > `Symfony` 
  - Cochez la case enable
  - remplacez les chemins commenceant par `app/` par `var/`
  - `web` devient `public`

**B. Installer les librairies externes**

On installe le projet via composer

    php bin/console composer:install
    
**C.Lancer le serveur**

    php bin/console server:start
    

