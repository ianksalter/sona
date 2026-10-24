# Sona

The term *Sona* is used to describe a collection of knowledge.

## Schemas and Artifacts

Knowledge is conceived of as a collection of *Artifacts*, Each Artifact may have one or more *Schemas* which it aims to satisfy. The notion of Artifact satisfying Schema generalises many situations that arise in the world as is illustrated by the following table[^1].

|Artifact |satisfies|Schema|
|------|-----|----|
|Response|answers|Question|
|Action|completes|Task|
|Solution|satisfies|Criteria|
|Element|is a member of|Set|
|Design|meets |Requirements|
|System|implements |System Design|
|Program|meets|Specification|
|Object|has type|Class|
|Object|implements|Interface|
|Object|implements|Trait|
|Code|passes|Tests|
|Proof|proves|Theorem|
|Model|satisfies|Axioms|

In some cases it may be easy to determine if an Artifact satisfies a Schema. For example it is normally simple to determine if an element belongs to a set or not. However in other cases, the situation may be more subtle. We might talk about how well a Design meets Requirements. 

## Quality and Measure

A Schema consists of a definition of *Quality* together with a function called a *Measure* which determines the Quality of a particular Artifact. The schemas definition of Quality enables the results of the Measure function to be compared.

## Entities

Sonas do not exist in isolation. They are used and modified by *Entities*. Entities may be:

* Human
* Computational
* Collections of Other Entities

Note this list is not intended to be exhaustive. In general an Entity is anything that is capable of using or modifying a Sona.

## Contributions, Contributors and Curators

Modifications to a Sona are called *Contributions*. Contributions are normally designed to improve the Quality of the Sona.

With respect to a Sona an Entity can play one of two roles

* *contributor* - who can
  * Propose Contributions to the Sona.
* *curator* - who can 
  * Propose Contributions to the Sona
  * Accept and reject proposed Contributions.

## Sonapana and Personal Sona

Sonas are created within a *Sonapana* - a network of Sonas. Within the Sonapana each Entity has a Sona for which they are the only Curator. It is through this *personal sona* that entities make and accept Contributions thereby improving the quality of individual Sonas and the Sonapana as a whole. One might think of the personal sona as the digital footprint of the entity.

## Subsonas

Sonas may be composed of other Sonas which in this context are called *Subsonas*. Subsonas may be used to separate key components of an overall Sona. For example two Entities Abelard and Eloise may each have a Subsona within each of their Personal Sonas to which they both act as Curators.

## Private and Public

A Subsona that can only be viewed by the Curators of that Sona is called *private*. Subsonas of the Sona that are not Private are considered public. Note that the public parts of a Sona are accessible to the Contributors of that Sona. Public parts of a Sona can be made accessible to any Entity of the Sonapana by a Contributor of that Sona.

## Schemas as Artifacts

A Schema may be an Artifact for another Schemas. A System may implement a System Design but that System Design may in turn meet System Requirements.

[^1]: Note the influence of [Martin-Lof Type Theory](https://www.cse.chalmers.se/~peterd/papers/MartinLöf1984.pdf).

