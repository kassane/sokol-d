import std.range;
import std.algorithm;
import ikod.containers.hashmap;

static string[] words =
[
        "hello", "this", "simple", "example", "should", "succeed", "or", "it",
        "should", "fail"
];

void main() @safe @nogc
{
    HashMap!(string, int) counter;
    // count words, simplest and fastest way
    foreach (word; words) {
        counter[word] = counter.getOrAdd(word, 0) + 1; // getOrAdd() return the value from the table or add it to the table
    }
    assert(counter.fetch("hello").ok);          // fetch() is a replacement to "in": you get "ok" if the key exists in the table
    assert(counter.fetch("hello").value == 1);  // and the value itself
    debug assert(counter["hello"] == 1);        // opIndex is not @nogc
    debug assert(counter["should"] == 2);       // opIndex is not @nogc
    assert(counter.contains("hello"));          // checks the key existence
    assert(counter.length == words.length - 1); // because "should" counts only once
    // iterators
    assert(counter.byKey.count == counter.byValue.count);
    assert(words.all!(w => counter.contains(w))); // all words in table
    assert(counter.byValue.sum == words.length); // sum of counters must equal to the number of words
}