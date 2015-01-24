This Week in D dev bits will be in here.

I probably won't push EVERYTHING to it but it will give you an idea
of what I'm up to.

upcoming.txt - the collection of stuff planned for soon

src - ddoc source code

tools - helper programs to generate stuff

web - the content that will go on the website.


TODO:

Make the RSS tool more better.
automate more fetching to make first entry quickly.
Some kind of email list gathering to send to people each week.

Write a bunch of content!



When each one is released, I'll prolly send it over to dlang.org
for proper publication each week instead of doing it on my computer.

But development will be done here, with just the final result going
into the dlang.org repo.



To build a file, from `src/../`, run:

dmd -D src/yourfile.dd src/common.ddoc -Ddweb
