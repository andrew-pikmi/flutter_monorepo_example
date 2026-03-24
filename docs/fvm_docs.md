## FVM: установка и применение

### 1. Назначение

`FVM` (`Flutter Version Management`) предназначен для управления версиями Flutter SDK.

Инструмент решает следующие задачи:

- закрепление конкретной версии Flutter для проекта;
- унификация среды разработки для команды и CI;
- безопасное переключение между каналами и версиями Flutter.

### 2. Установка

#### 2.1. Установка через Homebrew

```bash
brew tap leoafarias/fvm
brew install fvm
```

#### 2.2. Установка через Dart Pub

```bash
dart pub global activate fvm
```

#### 2.3. Установка через install script

```bash
curl -fsSL https://fvm.app/install.sh | bash
```

### 3. Применение в проекте

#### 3.1. Инициализация проекта на конкретной версии Flutter

```bash
fvm use 3.41.2
```

Команда `fvm use` инициализирует использование конкретной версии Flutter SDK в рамках проекта, обеспечивая её загрузку (при необходимости) и локальную привязку. В процессе создаётся конфигурация и служебная директория `.fvm`, через которую осуществляется доступ к выбранной версии SDK.

#### 3.2. Использование канала Flutter

```bash
fvm use stable
fvm use beta
fvm use master
```

#### 3.3. Выполнение команды без изменения конфигурации проекта

```bash
fvm spawn 3.41.2 <command>
```

### 4. Основные команды

#### 4.1. Скачивание и установка версии Flutter

```bash
fvm install [version] [options]
```

##### Параметры

- `-s, --setup` - Скачивает зависимости SDK после установки (по умолчанию: true)
- `--no-setup` - Пропустить загрузку зависимостей SDK для более быстрого кэширования
- `--skip-pub-get` - Пропустить разрешение зависимостей (pub get)

#### 4.2. Список установленных версий Flutter

```bash
fvm list
```

#### 4.3. Список доступных для установки релизов Flutter

```bash
fvm releases [options]
```

#### 4.4. Удаление скачанной версии Flutter

```bash
fvm remove [version] [options]
```

#### 4.5. Установка версии Flutter по умолчанию

```bash
fvm global [version]
```

#### 4.6. Удаление всех установленных версий Flutter

```bash
fvm destroy [options]
```

#### 4.7. Диагностика FVM

```bash
fvm doctor
```

### 5. Официальные источники

- [FVM](https://fvm.app/)
- [FVM GitHub](https://github.com/leoafarias/fvm)