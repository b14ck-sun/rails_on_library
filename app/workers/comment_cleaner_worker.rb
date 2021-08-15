class CommentCleanerWorker
    include Sidekiq::Worker
  
    def perform(*args)
        puts "Jooooob"
        for cm in Comment.all
            if cm.body.include? "bijan"
                edited = cm.body.gsub("bijan","***")
                puts edited
                cm.update(body: edited, state: "Edited")
            end
        end
    

    end
end
  