import os
import codecs

def cp1252_fallback(exc):
    if isinstance(exc, UnicodeEncodeError):
        res = bytearray()
        for c in exc.object[exc.start:exc.end]:
            res.append(ord(c) & 0xFF)
        return (bytes(res), exc.end)
    raise exc

codecs.register_error('cp1252_fallback', cp1252_fallback)

def fix_encoding():
    for root, _, files in os.walk('lib'):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Check for BOM
                has_bom = content.startswith('\ufeff')
                if has_bom:
                    content = content[1:]
                
                if 'Ã' in content or 'â' in content or 'Â' in content:
                    try:
                        bytes_1252 = content.encode('cp1252', errors='cp1252_fallback')
                        fixed_content = bytes_1252.decode('utf-8')
                        
                        with open(path, 'w', encoding='utf-8') as f:
                            if has_bom:
                                f.write('\ufeff')
                            f.write(fixed_content)
                        print(f"Fixed {path}")
                    except Exception as e:
                        print(f"Failed {path}: {e}")

if __name__ == '__main__':
    fix_encoding()
