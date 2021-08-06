import os
import sys
import glob
import re

kw_bold = ['Bold']
kw_thin = ['Thin']
kw_hairline = ['Hairline']
kw_extra_bold = ['Extra', 'Bold']
kw_ultra_bold = ['Ultra', 'Bold']
kw_light = ['Light']
kw_regular = ['Regular']
kw_normal = ['Normal']
kw_black = ['Black']
kw_heavy = ['Heavy']
kw_semi_bold = ['Semi', 'Bold']
kw_medium = ['Medium']
kw_extra_light = ['Extra', 'Light']
kw_ultra_light = ['Ultra', 'Light']
# kw_black_italic = ['Black', 'Italic']
# kw_thin_italic = ['Thin', 'Italic']
# kw_medium_italic = ['Medium', 'Italic']
# kw_light_italic = ['Light', 'Italic']
# kw_bold_italic = ['Bold', 'Italic']
# kw_extra_bold_italic = ['Extra', 'Bold', 'Italic']
# kw_semi_bold_italic = ['Semi', 'Bold', 'Italic']
# kw_extra_light_italic = ['Extra', 'Light', 'Italic']
# kw_regular_italic = ['Regular', 'Italic']

if len(sys.argv) == 2:
    selectedDir = sys.argv[1]

    fullPath = os.getcwd() + '/' + selectedDir

    lastdir = fullPath.split('/')[-1]

    if (os.path.isdir(fullPath)):
        os.chdir(fullPath)
        output = '  fonts:\n    - family: ' + \
            lastdir.capitalize() + '\n      fonts:\n'
        for font in glob.glob("*"):
            if (font.endswith('.otf') or font.endswith('.ttf')):
                type = font.replace(lastdir.capitalize() + '-', '')
                ext = os.path.splitext(font)
                type = type.replace(ext[1], '')
                type_list = re.findall('[A-Z][^A-Z]*', type)
                if set(kw_black) == set(type_list) or set(kw_heavy) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 900\n'
                if set(kw_extra_bold) == set(type_list) or set(kw_ultra_bold) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 800\n'
                if set(kw_bold) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 700\n'
                if set(kw_semi_bold) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 600\n'
                if set(kw_medium) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 500\n'
                if set(kw_regular) == set(type_list) or set(kw_normal) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 400\n'
                if set(kw_light) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 300\n'
                if set(kw_extra_light) == set(type_list) or set(kw_ultra_light) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 200\n'
                if set(kw_thin) == set(type_list) or set(kw_hairline) == set(type_list):
                    output += '        - asset: assets/fonts/' + \
                        selectedDir + '/' + font + '\n          weight: 100\n'
        print(output)

    else:
        print('Folder \'' + selectedDir + '\' does not exist!')
else:
    print('Please specify ONLY ONE folder with fonts!')
