#include <QObject>
#include <QUrl>

class FolderPathHelper : public QObject {
    Q_OBJECT

  public:
    using QObject::QObject;

    Q_INVOKABLE QString toLocalPath(const QUrl& url) const {
        return url.toLocalFile();
    }
};