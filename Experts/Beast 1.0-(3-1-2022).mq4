/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                         B e a s t   1 . 0 . m q 4   |  
 / / |                                                                                                           H a w k   T r a d i n g   |  
 / / |                                                                                           h t t p s : / / w w w . m q l 5 . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # i n c l u d e   < s t d e r r o r . m q h >  
 # i n c l u d e   < s t d l i b . m q h >  
  
 # p r o p e r t y   c o p y r i g h t   " H a w k   T r a d i n g "  
 # p r o p e r t y   l i n k             " h t t p s : / / w w w . m q l 5 . c o m "  
 # p r o p e r t y   v e r s i o n       " 1 . 0 0 "  
 # p r o p e r t y   s t r i c t  
  
 e x t e r n   d o u b l e   d S t e p S i z e   =   . 0 0 0 4 ;  
 i n p u t   d o u b l e   d E x p e c t e d P r o f i t   =   1 0 0 ;  
 i n p u t   d o u b l e   d E x p e c t e d L o s s   =   - 1 0 0 ;  
 e x t e r n   d o u b l e   d I n i t i a l L o t s   =   0 . 0 1 ;  
 i n p u t   d o u b l e   i M u l t i p l i e r   =   2 ;  
  
 i n t   i P i p s   =   1 ;  
 d o u b l e   d S e l l S t o p L o s s   =   0 ;  
 d o u b l e   d B u y S t o p L o s s   =   0 ;  
 d o u b l e   d S e l l T a k e P r o f i t   =   0 ;  
 d o u b l e   d B u y T a k e P r o f i t   =   0 ;  
 d o u b l e   d A v g S e l l C l o s e P r i c e   =   0 ;  
 d o u b l e   d A v g B u y C l o s e P r i c e   =   0 ;  
 d o u b l e   d M i n B u y P r i c e   =   0 ;  
 d o u b l e   d M a x B u y P r i c e   =   9 9 9 9 ;  
 d o u b l e   d M i n S e l l P r i c e   =   0 ;  
 d o u b l e   d M a x S e l l P r i c e   =   9 9 9 9 ;  
 d o u b l e   d A c c u m u l a t e d B u y L o t S i z e   =   0 . 0 0 ;  
 d o u b l e   d A c c u m u l a t e d S e l l L o t S i z e   =   0 . 0 0 ;  
 d o u b l e   d L a s t B u y L o t s   =   0 . 0 0 ;  
 d o u b l e   d L a s t S e l l L o t s   =   0 . 0 0 ;  
 d o u b l e   d L a s t O r d e r L o t s   =   0 . 0 0 ;  
 d o u b l e   d L a s t B u y P r i c e   =   0 . 0 0 ;  
 d o u b l e   d L a s t S e l l P r i c e   =   0 . 0 0 ;  
 d o u b l e   a v g S e l l P r i c e   =   0 ;  
 d o u b l e   a v g B u y P r i c e   =   0 ;  
 d o u b l e   d L a s t E x e c u t e d P r i c e   =   0 . 0 0 ;  
  
 i n t   O n I n i t ( )  
 {  
       E v e n t S e t T i m e r ( 1 ) ;  
       r e t u r n ( I N I T _ S U C C E E D E D ) ;  
        
 }  
      
      
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   E x p e r t   d e i n i t i a l i z a t i o n   f u n c t i o n                                                                   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   O n D e i n i t ( c o n s t   i n t   r e a s o n )  
 {  
       E v e n t K i l l T i m e r ( ) ;  
 }  
  
 v o i d   i n i t V a r i a b l e ( )  
 {  
        
       i P i p s   =   1 ;  
       d S e l l S t o p L o s s   =   0 ;  
       d B u y S t o p L o s s   =   0 ;  
       d S e l l T a k e P r o f i t   =   0 ;  
       d B u y T a k e P r o f i t   =   0 ;  
       d A v g S e l l C l o s e P r i c e   =   0 ;  
       d A v g B u y C l o s e P r i c e   =   0 ;  
       d M i n B u y P r i c e   =   0 ;  
       d M a x B u y P r i c e   =   9 9 9 9 ;  
       d M i n S e l l P r i c e   =   0 ;  
       d M a x S e l l P r i c e   =   9 9 9 9 ;  
       d A c c u m u l a t e d B u y L o t S i z e   =   0 . 0 0 ;  
       d A c c u m u l a t e d S e l l L o t S i z e   =   0 . 0 0 ;  
       d L a s t B u y L o t s   =   0 . 0 0 ;  
       d L a s t S e l l L o t s   =   0 . 0 0 ;  
       d L a s t B u y P r i c e   =   0 . 0 0 ;  
       d L a s t S e l l P r i c e   =   0 . 0 0 ;  
       a v g S e l l P r i c e   =   0 ;  
       a v g B u y P r i c e   =   0 ;  
       d L a s t O r d e r L o t s   =   0 . 0 0 ;  
  
 }  
      
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   E x p e r t   t i c k   f u n c t i o n                                                                                           |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   O n T i c k ( )  
 {  
       / / p r i n t f ( " - - - - - - - - - - - - - - B e g i n - - - - - - - - - - - - - - - " ) ;  
       d o u b l e   p r o f i t = 0 ;  
       c a l c M i n M a x P r i c e ( ) ;  
       i f ( ( A s k - B i d )   > =   d S t e p S i z e )  
       {  
             d S t e p S i z e   =   d S t e p S i z e   +   P o i n t ;  
       }  
       p r i n t f ( " s t e p :   % f " , d S t e p S i z e ) ;  
       i f   ( d A c c u m u l a t e d B u y L o t S i z e   >   0 )  
       {  
             / / i f ( A s k   > =   ( d M a x B u y P r i c e   +   d S t e p S i z e ) )  
             i f ( A s k   > =   ( d L a s t E x e c u t e d P r i c e   +   d S t e p S i z e )   )  
             {  
                   / / p r i n t f ( " B u y   O r d e r   N u m b e r :   % d " , p l a c e B u y O r d e r ( ( d A c c u m u l a t e d B u y L o t S i z e + d A c c u m u l a t e d S e l l L o t S i z e ) ) ) ;  
                   / / p l a c e B u y O r d e r ( ( ( d A c c u m u l a t e d B u y L o t S i z e + d A c c u m u l a t e d S e l l L o t S i z e ) * i M u l t i p l i e r ) / ( 2 * d I n i t i a l L o t s ) ) ;  
                   p l a c e B u y O r d e r ( d L a s t O r d e r L o t s * i M u l t i p l i e r ) ;  
             }  
             i f ( A s k   < =   ( d M i n B u y P r i c e   -   d S t e p S i z e ) )  
             {  
               / /     p r i n t f ( " B u y   O r d e r   N u m b e r :   % d " , p l a c e B u y O r d e r ( d L a s t B u y L o t s * i M u l t i p l i e r ) ) ;  
             }  
       }  
       e l s e  
       {  
             p r i n t f ( " B u y   O r d e r   N u m b e r :   % d " , p l a c e B u y O r d e r ( d I n i t i a l L o t s ) ) ;  
       }  
       i f   ( d A c c u m u l a t e d S e l l L o t S i z e   >   0 )  
       {  
             / / i f ( B i d   > =   ( d M a x S e l l P r i c e   +   d S t e p S i z e ) )  
             i f ( B i d   > =   ( d L a s t E x e c u t e d P r i c e   +   d S t e p S i z e ) )  
             {  
                 / /   p r i n t f ( " S e l l   O r d e r   N u m b e r :   % d " , p l a c e S e l l O r d e r ( d L a s t S e l l L o t s * i M u l t i p l i e r ) ) ;  
             }  
             / / i f ( B i d   < =   ( d M i n S e l l P r i c e   -   d S t e p S i z e ) )  
             i f ( B i d   < =   ( d L a s t E x e c u t e d P r i c e   -   d S t e p S i z e ) )  
             {  
                   / / p r i n t f ( " S e l l   O r d e r   N u m b e r :   % d " , p l a c e S e l l O r d e r ( d A c c u m u l a t e d B u y L o t S i z e + d A c c u m u l a t e d S e l l L o t S i z e ) ) ;  
                   / / p l a c e S e l l O r d e r ( ( ( d A c c u m u l a t e d B u y L o t S i z e + d A c c u m u l a t e d S e l l L o t S i z e ) * i M u l t i p l i e r ) / ( 2 * d I n i t i a l L o t s ) ) ;  
                   p l a c e S e l l O r d e r ( d L a s t O r d e r L o t s * i M u l t i p l i e r ) ;  
             }  
       }  
       e l s e  
       {  
             p r i n t f ( " S e l l   O r d e r   N u m b e r :   % d " , p l a c e S e l l O r d e r ( d I n i t i a l L o t s ) ) ;  
       }  
        
       c a l c M i n M a x P r i c e ( ) ;  
        
       / / p r i n t f ( " A c c u m u l a t e d   B u y :   % f ;   M a x   B u y   P r i c e :   % f ;   M i n   B u y   P r i c e :   % f   " , d A c c u m u l a t e d B u y L o t S i z e , d M a x B u y P r i c e , d M i n B u y P r i c e ) ;  
       / / p r i n t f ( " A c c u m u l a t e d   S e l l :   % f ;   M a x   S e l l   P r i c e :   % f ;   M i n   S e l l   P r i c e :   % f   " , d A c c u m u l a t e d S e l l L o t S i z e , d M a x S e l l P r i c e , d M i n S e l l P r i c e ) ;  
       / / p r i n t f ( " T o t a l   P r o f i t :   % f ;   E x p e c t e d   P r o f i t :   % f   " , t o t a l P r o f i t ( ) , ( ( d I n i t i a l L o t s *   d E x p e c t e d P r o f i t   )   +   ( A s k   -   B i d ) ) ) ;  
       i f   ( d A c c u m u l a t e d B u y L o t S i z e   >   0   | |   d A c c u m u l a t e d S e l l L o t S i z e   >   0 )  
       {  
       / / p r i n t f ( " % f " , t o t a l P r o f i t ( ) ) ;  
             / / i f ( A s k   > =   d M a x B u y P r i c e   | |   B i d   < =   d M i n S e l l P r i c e )  
             / / {  
             p r o f i t   =   t o t a l P r o f i t ( ) ;    
             i f ( p r o f i t   >     d E x p e c t e d P r o f i t       )  
             {  
         / /           p r i n t f ( " T o t a l   P r o f i t :   % f " ,   t o t a l P r o f i t ( ) ) ;  
                   / / p r i n t f ( " T o t a l   P r o f i t :   % f ;   E x p e c t e d   P r o f i t :   % f   " , t o t a l P r o f i t ( ) , d E x p e c t e d P r o f i t ) ;  
                       p r i n t f ( " T o t a l   P r o f t :   % f ,   E x p e c t e d   P r o f i t :   % f " ,   p r o f i t ,   d E x p e c t e d P r o f i t     ) ;  
                       c l o s e O p e n O r d e r s ( ) ;  
             }  
             / / }  
       }  
        
       i f   ( d A c c u m u l a t e d B u y L o t S i z e   >   0   | |   d A c c u m u l a t e d S e l l L o t S i z e   >   0 )  
       {  
       / / p r i n t f ( " % f " , t o t a l P r o f i t ( ) ) ;  
             / / i f ( A s k   > =   d M a x B u y P r i c e   | |   B i d   < =   d M i n S e l l P r i c e )  
             / / {  
             p r o f i t   =   t o t a l P r o f i t ( ) ;    
             i f ( p r o f i t   < =     d E x p e c t e d L o s s       )  
             {  
         / /           p r i n t f ( " T o t a l   P r o f i t :   % f " ,   t o t a l P r o f i t ( ) ) ;  
                   / / p r i n t f ( " T o t a l   P r o f i t :   % f ;   E x p e c t e d   P r o f i t :   % f   " , t o t a l P r o f i t ( ) , d E x p e c t e d P r o f i t ) ;  
                       p r i n t f ( " T o t a l   L o s s :   % f ,   E x p e c t e d   L o s s :   % f " ,   p r o f i t ,   d E x p e c t e d L o s s     ) ;  
                       c l o s e O p e n O r d e r s ( ) ;  
             }  
             / / }  
       }  
     / /   p r i n t f ( " - - - - - - - - - - - - - - E n d - - - - - - - - - - - - - - - " ) ;  
 }  
  
 v o i d   c a l c M i n M a x P r i c e ( )  
 {  
       d o u b l e   d T o t a l O p e n S e l l L o t s   =   0 ;  
       d o u b l e   d T o t a l O p e n B u y L o t s   =   0 ;  
       i n t   l a s t S e l l O r d e r   =   0 ;  
       i n t   l a s t B u y O r d e r   =   0 ;  
       i n i t V a r i a b l e ( ) ;  
       f o r ( i n t   i P o s   =   O r d e r s T o t a l ( ) - 1 ;   i P o s   > =   0   ;   i P o s - - )    
         {  
             i f   ( O r d e r S e l e c t ( i P o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S )   & &     O r d e r S y m b o l ( )   = =   S y m b o l ( ) )  
             {  
                   i f ( d L a s t O r d e r L o t s   <   O r d e r L o t s ( ) )  
                   {  
                         d L a s t O r d e r L o t s   =   O r d e r L o t s ( ) ;  
                   }  
                   i f ( O r d e r T y p e ( )   = =   O P _ S E L L )  
                   {  
                         d T o t a l O p e n S e l l L o t s   + =   O r d e r L o t s ( ) ;  
                         i f   ( l a s t S e l l O r d e r   < =   O r d e r T i c k e t ( ) )  
                         {  
                               l a s t S e l l O r d e r   =   O r d e r T i c k e t ( ) ;  
                               d L a s t S e l l L o t s   =   O r d e r L o t s ( ) ;  
                               d L a s t S e l l P r i c e   =   O r d e r O p e n P r i c e ( ) ;  
                         }  
                         i f ( d M i n S e l l P r i c e   = =   0   | |   O r d e r O p e n P r i c e ( )   <   d M i n S e l l P r i c e )  
                         {  
                               d M i n S e l l P r i c e   =   O r d e r O p e n P r i c e ( ) ;  
                         }  
                         i f ( d M a x S e l l P r i c e   = =   9 9 9 9   | |   O r d e r O p e n P r i c e ( )   >   d M a x S e l l P r i c e )  
                         {  
                               d M a x S e l l P r i c e   =   O r d e r O p e n P r i c e ( ) ;  
                         }  
                   } e l s e  
                   {  
                         d T o t a l O p e n B u y L o t s   + =   O r d e r L o t s ( ) ;  
                         i f   ( l a s t B u y O r d e r   < =   O r d e r T i c k e t ( ) )  
                         {  
                               l a s t B u y O r d e r   =   O r d e r T i c k e t ( ) ;  
                               d L a s t B u y L o t s   =   O r d e r L o t s ( ) ;  
                               d L a s t B u y P r i c e   =   O r d e r O p e n P r i c e ( ) ;  
                         }  
                         i f ( d M i n B u y P r i c e   = =   0   | |   O r d e r O p e n P r i c e ( )   <   d M i n B u y P r i c e )  
                         {  
                               d M i n B u y P r i c e   =   O r d e r O p e n P r i c e ( ) ;  
                         }  
                         i f ( d M a x B u y P r i c e   = =   9 9 9 9   | |   O r d e r O p e n P r i c e ( )   >   d M a x B u y P r i c e )  
                         {  
                               d M a x B u y P r i c e   =   O r d e r O p e n P r i c e ( ) ;  
                         }  
                   }  
             }  
            
         }  
         d A c c u m u l a t e d S e l l L o t S i z e   =   d T o t a l O p e n S e l l L o t s ;  
         d A c c u m u l a t e d B u y L o t S i z e   =   d T o t a l O p e n B u y L o t s ;  
 }  
  
  
 i n t   p l a c e S e l l O r d e r ( d o u b l e   s e l l L o t S i z e )  
 {  
       i n t   i O r d e r N u m b e r   =   0 ;  
       / / p r i n t f ( " S e l l   P r i c e :   % f ;   L o t   S i z e :   % f ;     C l o s e   P r i c e :   % f " , B i d , s e l l L o t S i z e ,   d A v g S e l l C l o s e P r i c e ) ;  
       i O r d e r N u m b e r   =   O r d e r S e n d ( S y m b o l ( ) , O P _ S E L L , s e l l L o t S i z e , B i d , i P i p s , d S e l l S t o p L o s s , d A v g S e l l C l o s e P r i c e , " " , 0 , T i m e C u r r e n t ( ) + 7 0 0 ) ;  
       i f   ( i O r d e r N u m b e r   >   0 ) {  
           / /   p r i n t f ( " O r d e r   N u m b e r :   % d " , i O r d e r N u m b e r ) ;  
           d L a s t E x e c u t e d P r i c e   =   B i d ;  
       } e l s e {  
             p r i n t f ( " E r r o r :   % s " ,   E r r o r D e s c r i p t i o n ( G e t L a s t E r r o r ( ) ) ) ;  
       }  
       r e t u r n   i O r d e r N u m b e r ;  
 }  
  
 i n t   p l a c e B u y O r d e r ( d o u b l e   b u y L o t S i z e )  
 {  
       i n t   i O r d e r N u m b e r   =   0 ;  
       p r i n t f ( " B u y   P r i c e :   % f ;   L o t   S i z e :   % f ;   L o t :   % f " , A s k , b u y L o t S i z e ) ;  
       / / c a l c u l a t e A v g B u y P r i c e ( b u y L o t S i z e , A s k ) ;  
       i O r d e r N u m b e r   =   O r d e r S e n d ( S y m b o l ( ) , O P _ B U Y , b u y L o t S i z e , A s k , i P i p s , d B u y S t o p L o s s , d A v g B u y C l o s e P r i c e , " " , 0 , T i m e C u r r e n t ( ) + 7 0 0 ) ;  
        
       i f   ( i O r d e r N u m b e r   >   0 ) {  
             / / p r i n t f ( " O r d e r   N u m b e r :   % d " , i O r d e r N u m b e r ) ;  
             d L a s t E x e c u t e d P r i c e   =   A s k ;  
       } e l s e {  
        
             p r i n t f ( " E r r o r :   % s " ,   E r r o r D e s c r i p t i o n ( G e t L a s t E r r o r ( ) ) ) ;  
       }  
        
       r e t u r n   i O r d e r N u m b e r ;  
 }  
  
 d o u b l e   t o t a l P r o f i t ( )  
 {  
       / / d o u b l e   t o t a l S e l l C o s t   =   0 ;  
       / / d o u b l e   t o t a l B u y C o s t   =   0 ;  
       / / d o u b l e   s l i p p a g e   =   P o i n t   *   1 0 ;  
       / / d o u b l e   s l i p p a g e   =   0 ;  
       / / d o u b l e   t o t a l S e l l C o s t _ t e m p   =   0 ;  
       / / d o u b l e   t o t a l B u y C o s t _ t e m p   =   0 ;  
       / / s t r i n g   b a s e C u r r e n c y   =   S t r i n g S u b s t r ( S y m b o l ( ) , 3 ) ;  
       d o u b l e   p r o f i t   =   0 ;  
        
       f o r ( i n t   i P o s   =   O r d e r s T o t a l ( ) - 1 ;   i P o s   > =   0   ;   i P o s - - )    
         {  
             i f   ( O r d e r S e l e c t ( i P o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S )   & &     O r d e r S y m b o l ( )   = =   S y m b o l ( ) )  
             {  
                   p r o f i t   + =   O r d e r P r o f i t ( ) ;    
                   / / i f ( O r d e r T y p e ( )   = =   O P _ S E L L )  
                   / / {  
                         / / t o t a l S e l l C o s t   + =     ( O r d e r L o t s ( )   *   ( O r d e r O p e n P r i c e ( )   -   s l i p p a g e   )   ) ;  
                     / /     t o t a l S e l l C o s t _ t e m p   + =   ( O r d e r L o t s ( )   *   ( O r d e r O p e n P r i c e ( )     )   ) ;  
                          
                   / / }  
                   / / i f ( O r d e r T y p e ( )   = =   O P _ B U Y )  
                   / / {  
                         / / t o t a l B u y C o s t   + =     ( O r d e r L o t s ( )   *   ( O r d e r O p e n P r i c e ( )   +   s l i p p a g e ) ) ;  
                     / /     t o t a l B u y C o s t _ t e m p   + =   ( O r d e r L o t s ( )   *   O r d e r O p e n P r i c e ( )   ) ;  
                   / / }  
             }  
         }  
          
         / / i f   ( b a s e C u r r e n c y   ! =   " U S D " )  
         / / {  
             / / p r i n t f ( " T o t a l   S e l l   C o s t :   % f ;   T o t a l   B u y   C o s t :   % f ;   P r o f i t :   % f " , t o t a l S e l l C o s t _ t e m p , t o t a l B u y C o s t _ t e m p , ( ( ( t o t a l S e l l C o s t _ t e m p   -   ( d A c c u m u l a t e d S e l l L o t S i z e   *   A s k ) ) / A s k )   +   ( ( ( d A c c u m u l a t e d B u y L o t S i z e   *   B i d )   -   t o t a l B u y C o s t _ t e m p ) / B i d ) )   *   1 0 0 0 0 0 ) ;  
             / / p r o f i t   =   ( ( ( t o t a l S e l l C o s t _ t e m p   -   ( d A c c u m u l a t e d S e l l L o t S i z e   *   A s k ) ) / A s k )   +   ( ( ( d A c c u m u l a t e d B u y L o t S i z e   *   B i d )   -   t o t a l B u y C o s t _ t e m p ) / B i d ) )   *   1 0 0 0 0 0 ;  
              
         / / } e l s e {  
             / / p r i n t f ( " T o t a l   S e l l   C o s t :   % f ;   T o t a l   B u y   C o s t :   % f ;   P r o f i t :   % f " , t o t a l S e l l C o s t _ t e m p , t o t a l B u y C o s t _ t e m p , ( ( t o t a l S e l l C o s t _ t e m p   -   ( d A c c u m u l a t e d S e l l L o t S i z e   *   A s k ) )   +   ( ( d A c c u m u l a t e d B u y L o t S i z e   *   B i d )   -   t o t a l B u y C o s t _ t e m p ) )   *   1 0 0 0 0 0 ) ;  
             / / r e t u r n   ( ( t o t a l S e l l C o s t _ t e m p   -   ( d A c c u m u l a t e d S e l l L o t S i z e   *   A s k ) )   +   ( ( d A c c u m u l a t e d B u y L o t S i z e   *   B i d )   -   t o t a l B u y C o s t _ t e m p ) )   *   1 0 0 0 0 0 ;  
             / / p r o f i t   =   ( ( t o t a l S e l l C o s t _ t e m p   -   ( d A c c u m u l a t e d S e l l L o t S i z e   *   A s k ) )   +   ( ( d A c c u m u l a t e d B u y L o t S i z e   *   B i d )   -   t o t a l B u y C o s t _ t e m p ) )   *   1 0 0 0 0 0 ;  
         / / }  
         / / p r i n t f ( " O r d e r   P r o f i t :   % f   " , p r o f i t ) ;  
                    
         r e t u r n   p r o f i t ;  
          
 }  
  
 v o i d   c l o s e O p e n O r d e r s ( )  
 {  
       p r i n t f ( " c l o s i n g   o r d e r s " ) ;  
       f o r ( i n t   i P o s   =   O r d e r s T o t a l ( ) - 1 ;   i P o s   > =   0   ;   i P o s - - )    
       {  
             i f   ( O r d e r S e l e c t ( i P o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S )   & &   O r d e r S y m b o l ( )   = =   S y m b o l ( ) )  
             {  
                   i f ( O r d e r T y p e ( )   = =   O P _ S E L L ) {  
                         b o o l   r e s   =   O r d e r C l o s e ( O r d e r T i c k e t ( ) , O r d e r L o t s ( ) , B i d , i P i p s ) ;    
                   } e l s e {  
                         b o o l   r e s   =   O r d e r C l o s e ( O r d e r T i c k e t ( ) , O r d e r L o t s ( ) , A s k , i P i p s ) ;    
                   }  
             }  
       }  
       d L a s t E x e c u t e d P r i c e   =   0 . 0 0 ;  
        
 }  
  
 