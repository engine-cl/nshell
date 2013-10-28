nshell
======

**eNgine shell scripting framework.**  
*(because sysadmin needs write script all the time)*

**objetives:**
- less is plus
- write less
- create script more readeable
- think and write only logic script code
- don't write redundant code.
- support more *nix with the same code.

guide lines.
-------------
**functions**
<pre>
name_function ()
{
  ...
}
</pre>
**conditionals**
<pre>
if [ conditions ]; then
  ...
elif [ condition ]; then

else
  ...
fi
</pre>
**loops**
<pre>
for|while [ condition or iterator ] 
do
  ...
done
</pre>
**calls**

to execute commands or string functions use:
- good:
<pre>
$(called_cmd)
</pre>
- wrong:
<pre>
\`called_cmd\`
</pre> 
not use `` because $() is more redeable 

**comments**
<pre>
#/ name:
#/ usage:
#/ desc:
#/ usage as:
#/ params:
#/ return:
</pre>
this comment are parsed to build docs with shocco.sh
http://rtomayko.github.io/shocco/
