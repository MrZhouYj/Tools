require 'fileutils'
# 都是文件夹路径
@input_file = "class"
@output_file = "NewClass"
@ori_pre = "CA"
@new_pre = "TA"
@key_words = ['Model','Controller','ViewController','view','View','ViewCell','TableViewCell']
@ignore_files = ['CAImport','CADefined']
@words
@oldfilename_newfilename = Hash.new
@write_enable = false
@file_count = 0

def get_random_word
  idx = Random.rand(0...(@words.length))
  @words[idx].capitalize
end

def deal_words
  file = File.open("words.txt")
  words = ""
  file.each { |line|
    words += line
  }
  words = words.gsub!(/\W+/,' ')
  words =  words.split
  words = words.uniq
  @words = words.select { |w|
    w.length > 4
  }
end

def get_replace_word
  word = @words.first.capitalize + get_random_word
  @words.shift
  word
end

deal_words

def get_files_keys
  @oldfilename_newfilename.keys.sort { |x,y|
    y.length <=> x.length
  }
end

def deal_file file
  basename = File.basename file
  extname =  File.extname file
  filename = File.basename file, extname
  #p 'fullname== ' + file
  #p 'extname ==' + extname
  #p 'filename ==' + filename
  if @write_enable
    p '处理 basename ==' + basename
    if filename.start_with?(@ori_pre) && !@ignore_files.include?(filename)
      new_path = @output_file + '/' + @oldfilename_newfilename[filename] + extname
    else
      new_path = @output_file + '/' + basename
    end
    new_file = File.open(new_path, 'w')
    File.open(file, 'r').each { |line|
      buffer = line
      matched_keys = []
      get_files_keys.each { |key|
        newfilename = @oldfilename_newfilename[key]
        oldfilename = key
        _next = true
        if matched_keys.length
          matched_keys.each { |k|
            if k.include?(key)
              @logger.puts '***********'
              @logger.puts k + '---PK---' + key
              _next = false
              break
            end
          }
        end
        if _next && line.include?(oldfilename)
          matched_keys.push oldfilename
          @logger.puts '======================'
          @logger.puts '修改之前' + buffer
          @logger.puts '包括' + key
          @logger.puts 'newfilename ==== ' + newfilename
          @logger.puts 'oldfilename ==== ' + oldfilename
          buffer = buffer.gsub(oldfilename,newfilename)
          @logger.puts '修改之后' + buffer
        end
      }
      new_file.puts(buffer)
    }
    new_file.close
  else
    if @ignore_files.include?(filename)
      new_full_file_name = basename
    elsif  filename.start_with?(@ori_pre)
      new_file_name = ''
      if @oldfilename_newfilename.keys.include?(filename)
        new_file_name = @oldfilename_newfilename[filename]
      else
        new_file_name = @new_pre + get_replace_word
        #new_file_name = new_file_name.gsub(@ori_pre, @new_pre) # CA => MM
        @oldfilename_newfilename[filename] = new_file_name
        @logger.puts 'oldfilename==' + filename
        @logger.puts 'newfilename==' + new_file_name
        @replace_logger.puts '文件 === ' + filename + ' ===> ' + new_file_name
      end
      new_full_file_name = new_file_name + extname
      #@key_words.each { |w|
      #  if new_file_name.end_with?(w)
      #    end_string = w
      #  end
      #}
    else
      new_full_file_name = basename
    end
    File.new(@output_file + '/' + new_full_file_name, 'w+')
    @logger.puts '创建新文件'+ basename + '=>'  + new_full_file_name
    #else
      #p 'basename====' + basename
      #FileUtils.cp(file, @output_file + '/' + basename)
    #end
  end
end

def deal_files root
  Dir.foreach(root) { |file|
    if file == '.' || file == '..' || file.start_with?('.')
      next
    end
    d_file = root + '/' + file
    if File.directory? d_file
      #p '是目录'
      deal_files d_file
    elsif File.file? d_file
      #p '开始处hhhh文件' + d_file
      deal_file d_file
    end
  }
end

def deleteDirectory(dirPath)
  if File.directory?(dirPath)
    Dir.foreach(dirPath) do |subFile|
      if subFile != '.' and subFile != '..'
        deleteDirectory(File.join(dirPath, subFile));
      end
    end
    Dir.rmdir(dirPath);
  else
    File.delete(dirPath);
  end
end

if File.exists? @output_file
  deleteDirectory(@output_file) if File::directory? @output_file
end
Dir.mkdir(@output_file)

log_path = 'mix.log'
replace_path = 'replace_file.log'
# 新建log文件 .log
if File.exists?(log_path)
  File.delete(log_path)
  p '清空log文件'
end
File.new(log_path, 'w+')
@logger = File.open(log_path,'w')

# 新建修改过文件 .log
if File.exists?(replace_path)
  File.delete(replace_path)
  p '清空 replace 文件'
end
File.new(replace_path, 'w+')
@replace_logger = File.open(replace_path,'w')

deal_files @input_file
@write_enable = true
deal_files @input_file
p '==========='
p '混淆单词库个数'
p @words.length
p ' 处理文件个数 (相同文件名为一次)'
p @oldfilename_newfilename.keys.length
p @oldfilename_newfilename
p '=========='


