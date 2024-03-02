`ifndef AXI4_NON_BLOCKING_SLAVE_MEM_MODE_INCR_BURST_WRITE_READ_TEST_INCLUDED_
`define AXI4_NON_BLOCKING_SLAVE_MEM_MODE_INCR_BURST_WRITE_READ_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test
// Extends the base test and starts the virtual sequence of incr burst write and read sequences
//--------------------------------------------------------------------------------------------
class axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test extends axi4_base_test;
  `uvm_component_utils(axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test)

  //Variable : axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq_h
  //Instatiation of axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq
  axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq_h;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern virtual function void setup_axi4_slave_agent_cfg();
  extern function new(string name = "axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass : axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test::new(string name = "axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: setup_axi4_slave_agents_cfg
// Setup the axi4_slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test::setup_axi4_slave_agent_cfg();
  axi4_env_cfg_h.axi4_slave_agent_cfg_h = new[axi4_env_cfg_h.no_of_slaves];
  foreach(axi4_env_cfg_h.axi4_slave_agent_cfg_h[i])begin
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i] =
    axi4_slave_agent_config::type_id::create($sformatf("axi4_slave_agent_cfg_h[%0d]",i));
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].slave_id = i;
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].min_address = axi4_env_cfg_h.axi4_master_agent_cfg_h[i].
                                                           master_min_addr_range_array[i];
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].max_address = axi4_env_cfg_h.axi4_master_agent_cfg_h[i].
                                                           master_max_addr_range_array[i];
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].maximum_transactions = 3;
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].read_data_mode = SLAVE_MEM_MODE;
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].slave_response_mode = RESP_IN_ORDER;
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].qos_mode_type = QOS_MODE_DISABLE;

    
    if(SLAVE_AGENT_ACTIVE === 1) begin
      axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].is_active = uvm_active_passive_enum'(UVM_ACTIVE);
    end
    else begin
      axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].is_active = uvm_active_passive_enum'(UVM_PASSIVE);
    end 
    axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].has_coverage = 1; 
    
    uvm_config_db #(axi4_slave_agent_config)::set(this,"*env*",$sformatf("axi4_slave_agent_config[%0d]",i), axi4_env_cfg_h.axi4_slave_agent_cfg_h[i]);   
    uvm_config_db #(read_data_type_mode_e)::set(this,"*","read_data_mode",axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].read_data_mode);   
   `uvm_info(get_type_name(),$sformatf("\nAXI4_SLAVE_CONFIG[%0d]\n%s",i,axi4_env_cfg_h.axi4_slave_agent_cfg_h[i].sprint()),UVM_LOW);
  end
endfunction: setup_axi4_slave_agent_cfg

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Creates the axi4_virtual_incr_burst_write_seq sequence and starts the write and read virtual sequences
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test::run_phase(uvm_phase phase);

  axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq_h=axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq::type_id::create("axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq_h");
  `uvm_info(get_type_name(),$sformatf("axi4_non_blocking_slave_mem_mode_incr_burst_write_read_test"),UVM_LOW);
  phase.raise_objection(this);
  axi4_virtual_nbk_slave_mem_mode_incr_burst_write_read_seq_h.start(axi4_env_h.axi4_virtual_seqr_h);
  phase.drop_objection(this);

endtask : run_phase

`endif
