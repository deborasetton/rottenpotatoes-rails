logger = Rails.logger

def logger.highlight(msg)
  self.debug('---------------------------------------------------------------')
  self.debug(msg)
  self.debug('---------------------------------------------------------------')
end
