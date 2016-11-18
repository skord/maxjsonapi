module MaxAdmin
  class Parser < Parslet::Parser
    root(:document)
    rule(:document) { root.repeat.as(:root) }
    rule(:root) {(
                   (match["[:alnum:][:punct:] "].repeat.as(:root) >> newline) >>
                   items.repeat.as(:items)
                 ).repeat
               }
    rule(:items) {(list | key_value)}
    rule(:list) {
      tab.repeat(1) >> alnumspace.repeat.as(:list) >> str(":\n") >>
      listitems.repeat.as(:values)
    }

    rule(:key_value) {
      tab.repeat(1) >> key.repeat.as(:key) >> str(":") >>
      tabspace.repeat >> value.repeat.as(:value) >> newline
    }
    rule(:listitems) {(tab.repeat(2) >> value.repeat.as(:value) >> newline)}
    rule(:key) {match["0-9A-Za-z \."]}
    rule(:value) {match["[0-9A-Za-z], [:punct:]"]}
    rule(:space) {match[" "]}
    rule(:tabspace) {match["\t "]}
    rule(:newline) { str("\r").maybe >> str("\n") | str("\r") >> str("\n").maybe }
    rule(:tab) {match["\t"]}
    rule(:alnumspace) {match["[0-9A-Za-z] "]}
    rule(:alnum) {match["[0-9A-Za-z]"]}
  end
end

