# -*- coding: utf-8 -*-

module Rwsc
  module Utils
		module Pager
			def next_page
				if self.page >= self.last
					return nil
				end
				opts = copy_options
				opts[:page] = (self.page.to_i + 1).to_s

				eval("#{opts[:operation]}.find(opts)")
			end
			
			def previous_page
		  	if self.page.to_i <= 1
					return nil
				end
				opts = copy_options
				opts[:page] = (self.page.to_i - 1).to_s

				eval("#{opts[:operation]}.find(opts)")
			end

			def [](page)
			  if page < 1 or page > self.last.to_i
					return nil
			  end

				opts = copy_options
				opts[:page] = page.to_s

				eval("#{opts[:operation]}.find(opts)")
			end

			private
			def copy_options
				opts = {}
				self.args.each do |arg|
					opts[arg.key.to_s.intern] = arg.value.to_s
				end
				opts.delete "User-Agent".intern
				opts.delete :apiVersion

				opts
			end

		end
	end
end
