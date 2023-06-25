# CUSTOM PICKER

Custom picker module

## Getting Started

dependecies: <br />
    ... <br />
    ... <br />
    photo_manager: ^2.6.0 or other version <br />
    image_picker: ^0.8.7 or other version <br />
    camera: ^0.10.5+2 or other version <br />


### PATH 
-> lib>custom_picker(folder)

## Usage

### Method is:
```dart
customPicker(
  BuildContext context, 
  {
    required Function(Uint8List photo) onPhotoChoosen,
    required Function() onCancel,
    required Function() onDelete,
  }
)
```


```dart
//using
customPicker(
    context,
    onPhotoChoosen: (photo){
        print('photo choosen');
    },
    onCancel: (){
        print('cancel');
    },
    onDelete: (){
        print('delete');
    }
);
```
