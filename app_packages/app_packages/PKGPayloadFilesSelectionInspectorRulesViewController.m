/*
 Copyright (c) 2017, Stephane Sudre
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 - Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "PKGPayloadFilesSelectionInspectorRulesViewController.h"

#import "PKGPayloadTreeNode.h"
#import "PKGPayloadBundleItem.h"

#import "PKGCheckboxTableCellView.h"

#import "NSTableView+Selection.h"
#import "NSAlert+block.h"

#import "PKGLocatorPanel.h"

@interface PKGPayloadFilesSelectionInspectorRulesViewController () <NSTableViewDataSource,NSTableViewDelegate>
{
	IBOutlet NSButton * _allowDowngradeCheckBox;
	
	IBOutlet NSTableView * _locatorsTableView;
	
	IBOutlet NSButton * _addButton;
	IBOutlet NSButton * _removeButton;
	IBOutlet NSButton * _editButton;
}

- (IBAction)switchAllowDowngrade:(id)sender;

- (IBAction)addLocator:(id)sender;
- (IBAction)delete:(id)sender;
- (IBAction)editLocator:(id)sender;

@end

@implementation PKGPayloadFilesSelectionInspectorRulesViewController

- (void)WB_viewDidLoad
{
	[super WB_viewDidLoad];
	
	// A COMPLETER
}

- (void)refreshSingleSelection
{
	PKGPayloadTreeNode * tTreeNode=self.selectedItems.lastObject;
	PKGPayloadBundleItem * tBundleItem=[tTreeNode representedObject];
	
	if ([tBundleItem isKindOfClass:[PKGPayloadBundleItem class]]==NO)
		return;
	
	// Allow Downgrade
	
	_allowDowngradeCheckBox.state=(tBundleItem.allowDowngrade==YES) ? NSOnState : NSOffState;
	
	// Locators
	
	// A COMPLETER
	
	[_locatorsTableView reloadData];
}

#pragma mark -

- (IBAction)switchAllowDowngrade:(id)sender
{
	PKGPayloadTreeNode * tTreeNode=self.selectedItems.lastObject;
	PKGPayloadBundleItem * tBundleItem=[tTreeNode representedObject];
	
	tBundleItem.allowDowngrade=(_allowDowngradeCheckBox.state==NSOnState);
	
	[self noteDocumentHasChanged];
}

- (IBAction)addLocator:(id)sender
{
	PKGLocator * tNewLocator=[[PKGLocator alloc] init];
	
	tNewLocator.name=@"";	// A COMPLETER
	tNewLocator.identifier=@"fr.whitebox.Packages.locator.standard";
	
	PKGLocatorPanel * tLocatorPanel=[PKGLocatorPanel locatorPanel];
	
	tLocatorPanel.locator=tNewLocator;
	tLocatorPanel.payloadTreeNode=self.selectedItems.lastObject;
	
	// A COMPLETER
	
	[tLocatorPanel beginSheetModalForWindow:self.view.window completionHandler:^{
	
	
		// A COMPLETER
	}];
	
	/*NSMutableDictionary * tMutableDictionary;
	
	editLocatorMode_=NO;
	
	tMutableDictionary=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],ICDOCUMENT_LOCATOR_STATE,
						@"fr.whitebox.Packages.locator.standard",ICDOCUMENT_LOCATOR_IDENTIFIER,
						nil];
	
	if (tMutableDictionary!=nil)
	{
		if (locatorController_==nil)
		{
			locatorController_=[ICLocatorEditorController newController];
		}
		
		if (locatorController_!=nil)
		{
			[locatorController_ showEditorForWindow:[document_ windowForSheet] withDictionary:tMutableDictionary file:[array_ objectAtIndex:0] delegate:self];
		}
	}*/
	
	// A COMPLETER
}

- (IBAction)delete:(id)sender
{
	NSIndexSet * tIndexSet=_locatorsTableView.WB_selectedOrClickedRowIndexes;
	
	if (tIndexSet.count<1)
		return;
	
	NSAlert * tAlert=[[NSAlert alloc] init];
	tAlert.messageText=(tIndexSet.count==1) ? NSLocalizedString(@"Do you really want to remove this locator?",@"No comment") : NSLocalizedString(@"Do you really want to remove these locators?",@"No comment");
	tAlert.informativeText=NSLocalizedString(@"This cannot be undone.",@"No comment");
	
	[tAlert addButtonWithTitle:NSLocalizedString(@"Remove",@"No comment")];
	[tAlert addButtonWithTitle:NSLocalizedString(@"Cancel",@"No comment")];
	
	[tAlert WB_beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse bResponse){
		
		if (bResponse!=NSAlertFirstButtonReturn)
			return;
		
		PKGPayloadTreeNode * tTreeNode=self.selectedItems.lastObject;
		PKGPayloadBundleItem * tBundleItem=[tTreeNode representedObject];
		
		[tBundleItem.locators removeObjectsAtIndexes:tIndexSet];
		
		[_locatorsTableView deselectAll:self];
		
		
		[self noteDocumentHasChanged];
	}];
}

- (IBAction)editLocator:(id)sender
{
	PKGPayloadTreeNode * tTreeNode=self.selectedItems.lastObject;
	PKGPayloadBundleItem * tBundleItem=[tTreeNode representedObject];
	
	
	_locatorsTableView.WB_selectedOrClickedRowIndexes;
	
	// A COMPLETER
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)inTableView
{
	if (inTableView==_locatorsTableView)
	{
		PKGPayloadTreeNode * tTreeNode=self.selectedItems.lastObject;
		PKGPayloadBundleItem * tBundleItem=[tTreeNode representedObject];
		
		return tBundleItem.locators.count;
	}
	return 0;
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)inTableView viewForTableColumn:(NSTableColumn *)inTableColumn row:(NSInteger)inRow
{
	if (inTableView==_locatorsTableView)
	{
		PKGPayloadTreeNode * tTreeNode=self.selectedItems.lastObject;
		PKGPayloadBundleItem * tBundleItem=[tTreeNode representedObject];
		
		PKGLocator * tLocator=tBundleItem.locators[inRow];
		
		NSString * tTableColumnIdentifier=inTableColumn.identifier;
		NSTableCellView * tCellView=[_locatorsTableView makeViewWithIdentifier:tTableColumnIdentifier owner:self];
		
		if ([tTableColumnIdentifier isEqualToString:@"locator.state"]==YES)
		{
			NSButton * tCheckBox=((PKGCheckboxTableCellView *)tCellView).checkbox;
			
			tCheckBox.state=(tLocator.isEnabled==YES) ? NSOnState : NSOffState;
			
			return tCellView;
		}
		
		if ([tTableColumnIdentifier isEqualToString:@"locator.name"]==YES)
		{
			NSTextField * tTextField=tCellView.textField;
			
			tTextField.stringValue=tLocator.name;
			
			return tCellView;
		}
	}
	
	return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)inNotification
{
	if (inNotification.object!=_locatorsTableView)
		return;
	
	NSIndexSet * tSelectionIndexSet=_locatorsTableView.selectedRowIndexes;
	
	// Delete button state
	
	_removeButton.enabled=(tSelectionIndexSet.count>0);
	_editButton.enabled=(tSelectionIndexSet.count==1);
}

@end
