module Jekyll
  class RawScript < Generator
    # store the raw script of each translation in a script property
    def generate(site)
      puts "Extracting raw scripts from translations..."
      site.collections.each do |(label, collection)|
        next unless (label == "p5js" || label == "pde")
        puts "Processing collection: #{label}"
        collection.docs.each do |entry|
          script = entry.content.dup.to_s
          if script.empty?
            puts "Ignoring: No script found for #{entry.data["slug"]}"
            next
          end

          script.gsub!(/<script[^>]*>/, "")
          script.gsub!(/<\/script>/, "")
          entry.data["script"] = script
        end
      end
    end
  end
end
