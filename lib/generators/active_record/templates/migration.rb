class CreateTrolloTables < ActiveRecord::Migration
  def self.change

    create_table :trollo_lists do |t|
      t.string :name
      t.references :trollable, polymorphic: true
      t.timestamps
    end

    create_table :trollo_cards do |t|
      t.references :list
      t.integer :ordinal
      t.string :name
      t.text :description
      t.string :workflow_state
      t.timestamp :due_at
      t.references :trollable, polymorphic: true
      t.timestamps
    end

    create_table :trollo_tasklists do |t|
      t.references :card
      t.integer :ordinal
      t.string :name
      t.string :workflow_state
      t.timestamp :due_at
      t.references :trollable, polymorphic: true
      t.timestamps
    end

    create_table :trollo_tasks do |t|
      t.references :tasklist
      t.integer :ordinal
      t.string :name
      t.string :group
      t.string :workflow_state
      t.timestamp :due_at
      t.references :trollable, polymorphic: true
      t.timestamps
    end

    create_table :trollo_subscriptions do |t|
      t.references :list
      t.references :subscriber, polymorphic: true
    end

    create_table :trollo_labels do |t|
      t.string :name
    end

    create_table :trollo_labels_lists do |t|
      t.references :label
      t.references :list
    end

    create_table :trollo_cards_labels do |t|
      t.references :card
      t.references :label
    end

    add_index :trollo_lists, [:trollable_type, :trollable_id]

    add_index :trollo_cards, :list_id
    add_index :trollo_cards, [:trollable_type, :trollable_id]

    add_index :trollo_tasklists, :card_id
    add_index :trollo_tasklists, [:trollable_type, :trollable_id]

    add_index :trollo_tasks, :tasklist_id
    add_index :trollo_tasks, [:trollable_type, :trollable_id]
 
  end

end