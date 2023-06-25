# CUSTOM PICKER

Custom picker module

## Getting Started

dependecies:__
    ...__
    ...__
    photo_manager: ^2.6.0 or other version__
    image_picker: ^0.8.7 or other version__
    camera: ^0.10.5+2 or other version__


### PATH 
-> lib>custom_picker(folder)

## Usage

### Method is:
customPicker(
  BuildContext context, 
  {
    required Function(Uint8List photo) onPhotoChoosen,
    required Function() onCancel,
    required Function() onDelete,
  }
)



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