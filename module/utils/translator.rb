class Translator
    TRANSLATIONS = {
      'DF1' => 'Dance Figure (DF)',
      'CDP1' => 'Choregraphy (CDP)',
      'FWM1' => 'Footwork man (FM)',
      'FWL1' => 'Footwork woman (FW)',
      'sm' => 'Small mistakes (SM)',
      'bm' => 'Big mistakes (BM)',
      'Acro' => 'Acrobatic figure (Acro 1 to 6)',
    }
  
    def self.translate(key)
        TRANSLATIONS.fetch(key, key) # Return the translated value or the original key if not found
    end
  end