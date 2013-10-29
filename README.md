nshell
======

**eNgine shell scripting framework.**  
*(because sysadmin needs write script all the time)*

**objetives:**
- write onece and use much
- write less because less is a plus
- create script more readeable
- think and write only logic script code
- don't write redundant code.
- support more *nix with the same code.

guidelines.
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
in line conditions
<pre>
[[ $a -gt $b ]] && echo $a || echo $b
</pre>
compare integers
<pre>
-lt (<)
-gt (>)
-le (<=)
-ge (>=)
-eq (==)
-ne (!=)
</pre>
compare strings
<pre>
== (equal)
!= (distinct)
</pre>
**loops**
<pre>
for value in iterator
do
  ...
done
</pre>

<pre>
while [ conditions ]
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

**comments mandatory before function implementation**
<pre>
#/ name:
#/ usage:
#/ desc:
#/ usage as:
#/ params:
#/ return:
</pre>
ToDo: make a parser docs builder.
