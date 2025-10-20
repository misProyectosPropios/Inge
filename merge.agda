open import Data.Nat using (ℕ; zero; suc; _+_; _/_ ; _≤_; _≤?_)
open import Relation.Binary.PropositionalEquality using (_≡_; refl; sym; trans; cong)
open import Data.Empty using (⊥-elim)
open import Data.List using (List; []; _∷_)
open import Data.List.Base using(_++_)
open import Relation.Binary
open import Relation.Binary.Core using (Rel)
open import Data.Product using (_×_; Σ-syntax; _,_)
open import Data.Sum using (_⊎_; inj₁; inj₂)
open import Data.Nat using (ℕ; zero; suc; _+_; _≤_; _≟_)
open import Data.Nat.Properties using (≤-step; ≤-refl; ≤-trans; +-monoʳ-≤)
open import Relation.Nullary using (Dec; yes; no; ¬_)

{--
merge :  List ℕ → List ℕ → List ℕ
merge []           ys           = ys
merge xs           []           = xs
merge (x ∷ xs) (y ∷ ys) with x ≤? y
... | yes _ = x ∷ merge xs (y ∷ ys)
... | no _  = y ∷ merge (x ∷ xs) ys
--}

{--
mutual 
  mergeRight :  List ℕ → List ℕ → List ℕ  
  mergeRight x []              = x
  mergeRight [] y              = y
  mergeRight (x₁ ∷ x) (y₁ ∷ y) with x₁ ≤? y₁
  ... | yes _ = x₁ ∷ (mergeRight x  (y₁ ∷ y)) 
  ... | no  _ = y₁ ∷ (mergeLeft (x₁ ∷ x) y)

  mergeLeft :  List ℕ → List ℕ → List ℕ  
  mergeLeft x []              = x
  mergeLeft [] y              = y
  mergeLeft (x₁ ∷ x) (y₁ ∷ y) with x₁ ≤? y₁
  ... | yes _ = x₁ ∷ (mergeLeft x  (y₁ ∷ y)) 
  ... | no  _ = y₁ ∷ (mergeRight (x₁ ∷ x) y)
--}

take :  {a : Set} → ℕ → List a → List a
take zero b    = []
take (suc a) [] = []
take (suc a) (x ∷ b) = x ∷ take a b 

drop : {a : Set} → ℕ → List a → List a
drop zero b          = b
drop (suc a) []      = []
drop (suc a) (x ∷ b) = drop a b

length : {a : Set} → List a → ℕ
length []       = 0
length (x ∷ x₁) = 1 + length x₁

merge-sort : List ℕ → List ℕ
merge-sort x = let size = length x
                   toTake = size / 2
                   toDrop = toTake + 1
                   firstHalf = take toTake x
                   lastHalf = drop toDrop x
               in firstHalf ++ lastHalf


halve-list : {a : Set} {b : List a} → List a → Set
halve-list a = {!!}
