# music_app

A simple Music Flutter App.

- Domain-Driven Design
- Dependcy injection
- Auto-generated (Servcies, Models)
- Unit Testing
- Widgets Testing
- Integration Testing (E2E using Page Object Model)
- Hive(noSql Database)
# Flutter Version
3.3.2

## App demo

![](app.gif)

## Dependancies
- cupertino_icons: ^1.0.2
- flutter_svg: ^0.22.0
- flutter_bloc: ^7.3.0
- equatable: ^2.0.3
- injectable: ^1.5.0
- retrofit: ^2.0.1
- json_annotation: ^4.1.0
- intl: ^0.17.0
- hive: ^2.0.4

## Testing Overview

- **Integration Testing**: End-to-end testing to verify user workflows, using the Page Object Model (POM) for improved modularity and maintainability.

### Test Organization

- **Integration Tests**: Tests are located in the `test` directory.

### Page Object Model (POM) Approach

The POM pattern is used for integration tests to organize page interactions and ensure modularity.

- **Page Object Classes**: Defined under `test/page_objects/` directory, with each page having its own dedicated object class.
    - `home_page_object.dart`: Represents the Home Page.
    - `search_page_object.dart`: Represents the Search Page.
    - `album_page_object.dart`: Represents interactions with albums.