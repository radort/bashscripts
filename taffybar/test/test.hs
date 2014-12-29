import XMonad.Core
import Control.Monad.Reader

extract :: (MonadReader XConf m) => m a -> a
extract MonadReader d = d
