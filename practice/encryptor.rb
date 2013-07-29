class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter,rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split("")
    results = []
    results = letters.collect do |letter|
      encrypt_letter(letter,rotation)
    end
    results.join
  end

  def decrypt(string,rotation)
    encrypt(string, -rotation)
  end
  
  def encrypt_file(filename, rotation)
  # 1. Create the file handle to the input file
    input = File.open(filename, "r")
  # 2. Read the text of the input file
    input_text = input.read
  # 3. Encrypt the text
    encrypted_text = encrypt(input_text, rotation)
  # 4. Create a name for the output file
    output_filename = filename + ".encrypted"
  # 5. Create an output file handle
    output = File.open(output_filename, "w")
  # 6. Write out the text
    output.write(encrypted_text)
  # 7. Close the file
    output.close
  end
  
  def decrypt_file(filename, rotation)
    input = File.open(filename, "r:ASCII-8BIT")
    input_text = input.read
    decrypted_text = decrypt(input_text, rotation)
    output_filename = filename.gsub("encrypted", "decrypted")
    output = File.open(output_filename, "w")
    output.write(decrypted_text)
    output.close
  end

  def supported_characters
    (' '..'z').to_a
  end
  
  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message,attempt)
    end
  end
end
