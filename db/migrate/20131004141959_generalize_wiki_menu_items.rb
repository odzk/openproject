#-- encoding: UTF-8
#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2018 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

class GeneralizeWikiMenuItems < ActiveRecord::Migration[5.1]
  def up
    rename_table :wiki_menu_items, :menu_items
    add_column :menu_items, :type, :string
    rename_column :menu_items, :wiki_id, :navigatable_id

    MenuItem.find_each do |menu_item|
      menu_item.update_attribute :type, 'MenuItems::WikiMenuItem'
    end
  end

  def down
    rename_table :menu_items, :wiki_menu_items
    remove_column :wiki_menu_items, :type
    rename_column :wiki_menu_items, :navigatable_id, :wiki_id
  end
end
