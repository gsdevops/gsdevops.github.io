#DevOps principles:  


## Stability (Weight pulls towards to stable state) / Reliability:
* Notifications for failure / success (this way we know it did not fail)  
* Idempotence - if the process is run again - should not change result
e.g. after XX failed deployements - the first successful cleans all trash
* assume you are not alone and there is an uncontrolled process (or person that is not following the correct flow)


## Simplicity:  
* minimize 
    *   flow branches
    *   auto-corrections - adding the self healing flows usually add a significant number of defects (reduces reliability)  
* There is a single correct path, the erroneous paths are infinite
*

## Maintainability:
* documentation near/in the code, with examples
* self contained items


## Uniformity 
* Uniformity vs. local optimization


## State defragmentation: 
* Avoid indirect data-stores and try to stick to the source of truth (tags), avoid "state cloning" (like in ["Eragon"](https://youtu.be/UfDKAJQcFEE?t=23s) 'the thing is the word')
* Try and use the actual state when possible


## Prepare all in advance and the "start"

