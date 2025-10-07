# touying-criterion
"Criterion" slide master for the [typst](https://typst.app) presentation package [touying](https://touying-typ.github.io). 

It uses the *Source Sans 3* font as default, which can be downloaded [here](https://api.fontsource.org/v1/download/source-sans-3).

```bash
typst init @preview/touying-criterion:0.1.0
```

## Configuration

- `aspect-ratio`: Default is *"16-9"*, alternatively *"4-3"*
- `lang`: The language of the respective presentation (*default "en"*)
- `font`: The font of the presentation (*default "Source Sans 3"*)
- `text-size`: Size of the text content (*default "22pt"*)
- `show-level-one` (bool) Show section heading on the content slides (*default: true*)
- `footer`: The footer of the content slides (*default: none*)

Other parameters, such as `title`, `subtitle`, `author`, `date` and `institution` are taken from the `config-info` object, which looks as follows: 

```typst
  config-info(
    title: [The "Criterion" slide template],
    subtitle: [thy0s],
    author: [Computer Science Department],
    date: datetime.today(),
    institution: [Funk Town State University],
  )
```

## Slide types
- `#outline-slide`: Dedicated outline slide with 2 parameters
    + `depth`: Maximum heading level to display (*default: 2*)
    + `title`: Override the default *"Outline"*, e.g. when using a different language
- `#focus-slide` - High contrast slide with no configuration options

The template also shows a `#new-section-slide` for every level one heading and allows for overriding the default settings of `show-level-one` and `footer` by calling the `#slide` function directly.

## Credit 
Parts of this template were inspired by and taken from the [university theme](https://github.com/touying-typ/touying/blob/main/themes/university.typ) and the [metropolis theme](https://github.com/touying-typ/touying/blob/main/themes/metropolis.typ) aswell as the [clean-math-presentation](https://github.com/JoshuaLampert/clean-math-presentation).

## Contribution
If you have any problems with this template feel free to open an issue. Also, if you have anything usefult to add to this template, you can open a pull request and it will be looked at. 

All constructive contributions are welcome and highly appreciated!