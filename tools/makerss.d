import arsd.dom;
import std.file;

void main() {
	auto rss = new Document(`<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0"></rss>`, true, true);

	auto channel = rss.root.addChild("channel");

	channel.addChild("title", "This Week in D");
	channel.addChild("description", "A weekly newsletter about what's going on in the D Programming Language");
	channel.addChild("link", "http://arsdnet.net/this-week-in-d/");
	channel.addChild("ttl", "5000");

	// FIXME
	channel.addChild("lastBuildDate", "Mon, 12 Jan 2015 22:00:00 -0400");


	foreach(string file; ["../web/jan-12.html"]) {
		auto item = channel.addChild("item");
		item.addChild("title", "Issue #1");
		item.addChild("author", "destructionator+dweek@gmail.com");
		item.addChild("link", "http://arsdnet.net/this-week-in-d/jan-12.html");
		item.addChild("pubDate", "Mon, 12 Jan 2015 22:00:00 -0400");

		item.addChild("description", std.file.readText(file));
	}


	std.file.write("twid.rss", rss.toString());
}
