import arsd.dom;
import std.file;
import std.string;
import std.algorithm;

void main() {
	auto rss = new Document(`<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0"></rss>`, true, true);

	rss.setProlog = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n";

	auto channel = rss.root.addChild("channel");

	channel.addChild("title", "This Week in D");
	channel.addChild("description", "A weekly newsletter about what's going on in the D Programming Language");
	channel.addChild("link", "http://arsdnet.net/this-week-in-d/");
	channel.addChild("ttl", "5000");

	// this is updated below too
	channel.addChild("lastBuildDate", "Mon, 19 Jan 2015 12:00:00 -0400");

	struct Item {
		Element item;
		DateTime date;
	}

	Item[] items;

	foreach(DirEntry e; dirEntries("../web", "*.html", SpanMode.shallow)) {
		auto item = new Element("item");
		item.addChild("title", "placeholder");
		item.addChild("author", "destructionator+dweek@gmail.com");
		item.addChild("link", format("http://arsdnet.net/this-week-in-d/%s", e.name["../web/".length .. $]));

		auto entry = new Document(std.file.readText(e.name));
		auto date = entry.requireSelector("#title-date").innerText;
		DateTime dt;
		dt.month = to!Month(date[0 .. date.indexOf(" ")][0 .. 3].toLower);
		dt.day = to!int(date[date.indexOf(" ") + 1 .. date.indexOf(",")]);
		dt.year = to!int(date[date.indexOf(", ") + 2 .. $]);
		dt.hour = 12;
		item.addChild("pubDate", dt.printDate());

		entry.setProlog(""); // IE doesn't like DTDs embedded in here
		item.addChild("description", entry.toString());

		channel.requireSelector("lastBuildDate").innerText = dt.toISOExtString();

		items ~= Item(item, dt);
	}

	int issue = 1;
	foreach(item; sort!"a.date < b.date"(items)) {
		channel.addChild(item.item);
		item.item.requireSelector("title").innerText = format("Issue #%d", issue);
		issue++;
	}


	std.file.write("../web/twid.rss", rss.toString());
}

import std.conv;
import std.datetime;
string printDate(DateTime date) {
	return format(
		"%.3s, %02d %.3s %d %02d:%02d:%02d GMT", // could be UTC too
		to!string(date.dayOfWeek).capitalize,
		date.day,
		to!string(date.month).capitalize,
		date.year,
		date.hour,
		date.minute,
		date.second);
}


