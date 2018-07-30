#DevOps principles:  

## Simplicity:  
* minimize auto-corrections
* the main correct paths are few, the erronous paths are infinite

## Maintainability:
* documentation near/in the code, with examples
* self contained items

## Uniformity 
* Uniformity vs. local optimization

## Stability (Weight pulls towards to stable state):
* Idempotence
e.g. after XX failed deployements - the first successful cleans all trash
* assume you are not alone and there is an uncontrolled process (or person that is not following the correct flow)


## State defragmentation: 
* Avoid indirect data-stores and try to stick to the source of truth (tags), avoid "state cloning"



