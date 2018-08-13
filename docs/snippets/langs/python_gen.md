
# update python 2.7 version in place

[https://askubuntu.com/questions/725171/update-python-2-7-to-latest-version-of-2-x](https://askubuntu.com/questions/725171/update-python-2-7-to-latest-version-of-2-x )   

```shell
sudo add-apt-repository ppa:jonathonf/python-2.7 
sudo apt-get update 
sudo apt-get install python2.7 
python --version  
```



# py.test
...

# Usefull Links  

[weblogs](https://www.artima.com/weblogs/viewpost.jsp?thread=240845) 
 
[drastically-improve-your-python-understanding-pythons-execution-model](http://www.jeffknupp.com/blog/2013/02/14/drastically-improve-your-python-understanding-pythons-execution-model/)   

[python classes](http://www.jeffknupp.com/blog/2014/06/18/improve-your-python-python-classes-and-object-oriented-programming/)   

[python magic methods](http://www.rafekettler.com/magicmethods.html#appendix1) 



## Logging
* logger hierarchy  **ADD_ME**



## JINJA
in order to avoid adding newline after every template closure:
see here: [JINJA whitespace-control](http://jinja.pocoo.org/docs/2.10/templates/#whitespace-control)
Without newlines  
```jinja2
{% for i in insts %}
{{ "%s" % i['the_var'] }}
{% endfor %}
```  
With newlines
```jinja2
{% for i in insts %}
{{ "%s" % i['the_var'] }}
{% endfor %}
```