
module Helpers

    def email
        # karottenreibe@gmail.com
        Haml::Engine.new(<<EOS).to_html
%span.strong &#x6b;&#x61;&#x72;&#x6f;&#x74;&#x74;&#x65;&#x6e;&#x72;&#x65;&#x69;&#x62;&#x65;
\[
%span.strong
  %span.uiae _&#xe4;&#x74;_&nbsp;&#x67;&#x6d;&#x61;&#x69;&#x6c;
  _&#x64;&#xf6;&#x74;_ &#x63;&#x6f;&#x6d;
]
EOS
    end

end

