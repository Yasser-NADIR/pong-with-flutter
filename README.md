# pong_game
> dans la propriete BoxDecoration: on peut specifier shape si on veut une cercle parfaite
> LayoutBuilder est une widget aide à musurer l'espace dans un context
> Positioned est une widget qui positionne notre widget selon les direction (top, bottom, left right)
>Stack est un contenaire des widgets, sert à positionnner librement une liste des widgets
>BoxCtraints est un contenaire util pour spécifier max et min pour width et height. ils ont mise à jour dans l'execution
>pour construire une animation on a besoin de trois class
1. **Animation**: elle prend quelque valeur et les traduit en une animation. Cette classe ne lie à aucune widget dans l'écran
2. **AnimationController.AnimationController**: elle controlle l'animation d'un objet, par exemple il est utilisé pour démarer une animation, donné une durée pour une animation. Cette classe peut controller plusieurs animations
3. **Tween.Tween**: elle contient des valeurs qu'on a besoin pour changer dans une animation, exemple la distance, la position, le couleur etc.
>*SingleTickerProviderStateMixin* donne une *ticker*. un *ticker* envoye un signale chaque temps precisé
>pour utiliser les animation il faut suivre les étapes suivants
1. la création du *AnimationController*, en passant la durée d'animation, et un *TickerProvider*. Pour ce dernier on utilise un mixin *SingleTickerProviderStateMixin* avec *_pongState* pour utiliser la classe en question comme un *TickerProvider*
2. la création du *Animation* en utlisant la classe *Tween*. Pour le constructeur de *Tween* on passe le debut et la fin, par la suite on appele la méthode animate pour construire *Animation*
3. utiliser la méthode *addListinner* pour ajouter une fonction qui executera chaque fois la valeur du animtion change 
> la classe GuestureDetector vient pour detecter les gestes et le comportement de l'utilisateur, elle contient plusieurs evenement, comme *onTap* *onDoubleTap* etc